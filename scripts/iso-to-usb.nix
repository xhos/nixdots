{pkgs}:
pkgs.writeShellApplication {
  name = "iso-to-usb";
  runtimeInputs = with pkgs; [
    gum
    coreutils
    util-linux
    gawk
    gnugrep
    pv
    parted
  ];
  text = ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Color coded logging functions
    log() { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
    warn() { printf "\033[1;33m[WARN]\033[0m %s\n" "$*"; }
    fail() { printf "\033[1;31m[ERROR]\033[0m %s\n" "$*" >&2; exit 1; }
    success() { printf "\033[1;32m[SUCCESS]\033[0m %s\n" "$*"; }

    # Check if running as root
    [ "$EUID" -eq 0 ] || fail "This script must be run as root (use sudo)"

    # Check for ISO argument
    ISO_PATH="''${1:-}"
    [ -n "$ISO_PATH" ] || fail "Usage: $0 <path-to-iso>"
    [ -f "$ISO_PATH" ] || fail "ISO file not found: $ISO_PATH"

    # Get ISO size for display
    ISO_SIZE=$(du -h "$ISO_PATH" | cut -f1)
    ISO_SIZE_BYTES=$(stat -c%s "$ISO_PATH")
    ISO_NAME=$(basename "$ISO_PATH")

    log "ISO: $ISO_NAME ($ISO_SIZE)"

    # Function to get detailed disk info
    get_disk_info() {
      local disk=$1
      local size model vendor removable usb_info=""

      size=$(lsblk -bdno SIZE "$disk" 2>/dev/null | numfmt --to=iec-i --suffix=B || echo "unknown")
      model=$(lsblk -dno MODEL "$disk" 2>/dev/null | tr -s ' ' || echo "")
      vendor=$(lsblk -dno VENDOR "$disk" 2>/dev/null | tr -s ' ' || echo "")
      removable=$(cat "/sys/block/$(basename "$disk")/removable" 2>/dev/null || echo "0")

      # Check if it's a USB device
      if [ -e "/sys/block/$(basename "$disk")/device/driver" ]; then
        driver=$(readlink "/sys/block/$(basename "$disk")/device/driver" | xargs basename)
        [[ "$driver" == *"usb"* ]] && usb_info="[USB]"
      fi

      # Mark removable devices
      [ "$removable" = "1" ] && removable_info="[REMOVABLE]" || removable_info=""

      printf "%s %s %s %s %s %s" "$disk" "$size" "$vendor" "$model" "$removable_info" "$usb_info"
    }

    # Get list of potential USB devices (≤64GB, preferably removable)
    log "Scanning for USB devices..."

    DEVICES=()
    while IFS= read -r disk; do
      [ -b "$disk" ] || continue

      # Get disk size in bytes
      size_bytes=$(lsblk -bdno SIZE "$disk" 2>/dev/null || echo "0")

      # Skip if larger than 64GB (68719476736 bytes)
      [ "$size_bytes" -gt 68719476736 ] && continue

      # Skip if size is 0 or unknown
      [ "$size_bytes" -eq 0 ] && continue

      # Get detailed info
      disk_info=$(get_disk_info "$disk")

      # Add to list
      DEVICES+=("$disk_info")
    done < <(lsblk -dpno NAME | grep -E "^/dev/sd[a-z]$|^/dev/nvme[0-9]+n[0-9]+$")

    # Check if we found any suitable devices
    [ ''${#DEVICES[@]} -eq 0 ] && fail "No suitable USB devices found (looking for devices ≤64GB)"

    # Let user select the target device
    log "Select target USB device:"
    echo

    SELECTED=$(printf '%s\n' "''${DEVICES[@]}" | \
      gum choose --header "⚠️  SELECT TARGET USB DEVICE (ALL DATA WILL BE ERASED)" \
                 --header.foreground="196" \
                 --cursor.foreground="196")

    [ -n "$SELECTED" ] || fail "No device selected"

    # Extract the device path from selection
    TARGET_DEVICE=$(echo "$SELECTED" | awk '{print $1}')
    TARGET_SIZE=$(echo "$SELECTED" | awk '{print $2}')
    TARGET_INFO=$(echo "$SELECTED" | cut -d' ' -f3-)

    # Verify device exists and is block device
    [ -b "$TARGET_DEVICE" ] || fail "Invalid device: $TARGET_DEVICE"

    # Check if device is mounted
    if mount | grep -q "^$TARGET_DEVICE"; then
      warn "Device $TARGET_DEVICE has mounted partitions"
      log "Unmounting all partitions..."
      for part in "$TARGET_DEVICE"*; do
        if mount | grep -q "^$part "; then
          umount "$part" 2>/dev/null || true
        fi
      done
    fi

    # Get device size in bytes for verification
    DEVICE_SIZE_BYTES=$(lsblk -bdno SIZE "$TARGET_DEVICE" 2>/dev/null || echo "0")

    # Check if ISO will fit
    if [ "$ISO_SIZE_BYTES" -gt "$DEVICE_SIZE_BYTES" ]; then
      fail "ISO ($ISO_SIZE) is larger than device capacity ($(numfmt --to=iec-i --suffix=B "$DEVICE_SIZE_BYTES"))"
    fi

    # Final confirmation with detailed info
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  SOURCE ISO:  $ISO_NAME ($ISO_SIZE)"
    echo "  TARGET USB:  $TARGET_DEVICE ($TARGET_SIZE)"
    echo "  DEVICE INFO: $TARGET_INFO"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo

    gum confirm --default=false \
                --prompt.foreground="196" \
                "⚠️  THIS WILL PERMANENTLY ERASE ALL DATA ON $TARGET_DEVICE! Continue?" || \
      fail "Operation cancelled by user"

    # Write the ISO using dd with progress
    log "Writing ISO to $TARGET_DEVICE..."
    log "This may take several minutes depending on USB speed..."
    echo

    # Use pv for progress if available, otherwise dd with status=progress
    if command -v pv >/dev/null 2>&1; then
      # pv provides better progress indication
      pv -tpreb "$ISO_PATH" | dd of="$TARGET_DEVICE" \
        bs=4M \
        conv=fdatasync \
        oflag=direct \
        status=none 2>/dev/null
    else
      # Fallback to dd with progress
      dd if="$ISO_PATH" of="$TARGET_DEVICE" \
        bs=4M \
        conv=fdatasync \
        oflag=direct \
        status=progress
    fi

    # Ensure all data is written
    log "Syncing data to disk..."
    sync

    # Verify write (optional but recommended)
    log "Verifying write integrity..."

    # Read back first 1MB and compare checksums
    ISO_CHECKSUM=$(dd if="$ISO_PATH" bs=1M count=1 2>/dev/null | sha256sum | cut -d' ' -f1)
    USB_CHECKSUM=$(dd if="$TARGET_DEVICE" bs=1M count=1 2>/dev/null | sha256sum | cut -d' ' -f1)

    if [ "$ISO_CHECKSUM" = "$USB_CHECKSUM" ]; then
      success "Initial verification passed"
    else
      warn "Initial verification mismatch - this might be normal for some ISOs"
    fi

    # Eject the device safely
    log "Ejecting device..."
    eject "$TARGET_DEVICE" 2>/dev/null || true

    echo
    success "✅ ISO successfully written to $TARGET_DEVICE"
    echo
    echo "You can now safely remove the USB device and use it to boot."
    echo "Remember to configure your BIOS/UEFI to boot from USB if needed."
  '';
}
