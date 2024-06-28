systemd.services."modeSwitcherService" = {
  script = ''
    case "$1" in
        -s)
            # Set performance mode to low-power
            echo "Setting performance mode to low-power..."
            echo low-power | sudo tee /sys/firmware/acpi/platform_profile > /dev/null
            ;;
        -g)
            # Get current performance mode
            echo "Current performance mode:"
            cat /sys/firmware/acpi/platform_profile
            ;;
        *)
            echo "Invalid argument. Use -s to set performance mode to low-power or -g to get the current performance mode."
            exit 1
            ;;
    esac
  '';
}