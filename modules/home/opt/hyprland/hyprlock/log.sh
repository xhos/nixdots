#!/usr/bin/bash

#  Define an array of faux log messages.
LOGS=(
  "[SEC] Protocol initiate: 011010110101"
  "[DBG] Encryption: A9.8_Overflow"
  "[SYS] Unstable subroutine: __Err_X_42"
  "[ERR] Intrusion detected: 0xDEADBEEF"
  "[ALERT] Suspicious access: OVERRIDE SEQUENCE INITIATED"
  "[SEC] Countermeasure activated: 0xA1B2C3"
  "[DBG] Kernel anomaly: Module X fail (Error: 0xCAFEBABE)"
  "[LOG] Data flux: 100% capacity reached"
  "[SEC] Silo breach: A-Lockdown // REBOOT Initiated"
  "[ALERT] Temporal anomaly detected: S-0xFADEBABE"
  "[DBG] Cryptic sequence: O-A-847"
  "[ERR] System distortion: //SYS: ABAC-946"
  "[WARN] Flux capacitor overloading: SUM-TEMP Exceeded!"
  "[ALERT] Glitch matrix activated: 011011110110"
)

# Choose a random log message from the array.
len=${#LOGS[@]}
rand_index=$(( RANDOM % len ))
message="${LOGS[$rand_index]}"

# Set the target fixed length.
target_length=60
# Format the message to be exactly target_length characters.
# If it's longer than target_length, it will be truncated; if shorter, spaces are appended.
message=$(printf "%-${target_length}.${target_length}s" "$message")

# Define an array of glitch strings (ASCII-only, since your font doesn't support Greek).
GLITCHES=( "//" "##" "**" "!!" "--" "%%" "++" "~~" )

# Function that inserts random glitch strings into the given text.
glitch_text() {
    local input="$1"
    local output=""
    local i char rand_val rand_glitch

    # Loop through each character in the input string.
    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        output+="$char"
        # With a 15% chance, insert a random glitch string.
        rand_val=$(( RANDOM % 100 ))
        if (( rand_val >= 95 )); then
            rand_glitch=${GLITCHES[$(( RANDOM % ${#GLITCHES[@]} ))]}
            output+="$rand_glitch"
        fi
    done
    echo "$output"
}

# Apply the glitch effect to the formatted message.
glitched_message=$(glitch_text "$message")

# Output the final glitched message.
echo "$glitched_message"