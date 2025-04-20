#!/usr/bin/env sh
#
# terminal.sh — Hyprlock “typewriter” leak with persistent random style lines
#
# Usage in hyprlock.conf:
# text = cmd[update:200] ~/.config/hypr/hyprlock/reveal.sh \
#        "$USER" "$DESC" "$TIME" "$TIME12" "$LAYOUT" \
#        "$ATTEMPTS" "$FAIL" "$PAMPROMPT" "$PAMFAIL" \
#        "$FPRINTPROMPT" "$FPRINTFAIL"

# ─── 1) Parse Hyprlock variables ─────────────────────────────────────────────
USER="$1"; DESC="$2"; TIME24="$3"; TIME12="$4"; LAYOUT="$5"
ATTEMPTS="$6"; FAIL="$7"; PAMPROMPT="$8"; PAMFAIL="$9"
FPRINTPROMPT="${10}"; FPRINTFAIL="${11}"

# ─── 2) State files for per‑lock reset & line counting ──────────────────────
STATEFILE="/tmp/hyprlock_reveal_idx"
PIDFILE="/tmp/hyprlock_reveal_pid"

[ -f "$PIDFILE" ] && oldpid=$(cat "$PIDFILE") || oldpid=""
if [ "$oldpid" != "$PPID" ]; then
  rm -f "$STATEFILE" /tmp/hyprlock_style{1,2,3,4}
fi
echo "$PPID" > "$PIDFILE"

# ─── 3) System info & uptime formatting ─────────────────────────────────────
KERNEL=$(uname -r)
DISTRO=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2- | tr -d '"')
ACTUAL_UP=$(uptime -p | sed 's/^up //')
UPTIME_DISPLAY="2794 years, 7 months, $ACTUAL_UP"

# ─── 4) Define 4 pools of stylistic Marathon‑flavored lines ─────────────────
STYLE1_POOL=(
  "Mjölnir markings bleed across the console"
  "Durandal’s echo fractures the signal"
  "Pfhor glyphs pulse with stolen power"
  "Leela’s code whispers in the void"
  "S’pht runes shimmer on Deimos’ hull"
)

STYLE2_POOL=(
  "Flux cascade awaiting containment"
  "Temporal rift detected at τ‑Ceti IV"
  "Memory core spooling ancient logs"
  "Entropy threshold at 98.7%"
  "Quantum shard misalignment warning"
)

STYLE3_POOL=(
  "Protocol Σ‑13 corrupted beyond repair"
  "Subsystem Ω offline—rerouting..."
  "Override key queued for input"
  "Chain of command severed at node 7"
  "Decision matrix reports existential loop"
)

STYLE4_POOL=(
  "Boot sequence archived in Marathon_OS"
  "Hivemind vector flagged for review"
  "Archive logs fracturing under load"
  "Sanity checksum nearing failure"
  "Interlock safety measures bypassed"
)

# ─── 5) On first run per lock, pick & store one line from each pool ─────────
pick_and_store() {
  pool_name="$1[@]"; idx="$2"; file="/tmp/hyprlock_style$idx"
  if [ ! -f "$file" ]; then
    arr=( "${!pool_name}" )
    echo "${arr[RANDOM % ${#arr[@]}]}" > "$file"
  fi
}
pick_and_store STYLE1_POOL 1
pick_and_store STYLE2_POOL 2
pick_and_store STYLE3_POOL 3
pick_and_store STYLE4_POOL 4

# ─── 6) Read back the four style lines ──────────────────────────────────────
R1=$(cat /tmp/hyprlock_style1)
R2=$(cat /tmp/hyprlock_style2)
R3=$(cat /tmp/hyprlock_style3)
R4=$(cat /tmp/hyprlock_style4)

# ─── 7) Build your BLOCK_LINES array ────────────────────────────────────────
BLOCK_LINES=(
  "███ TERMINAL ACCESS: 004121.25.1 ███"
  "MESSAGE RECEIVED: <03.02.2250414>"
  ""
  "> EXECUTE AUTHORIZATION PROTOCOL // Kernel v$KERNEL"
  "> Distribution: $DISTRO"
  "> Layout: [$LAYOUT]"
  "> Time: $TIME24"
  ""
  "███ ACCESS_LOG[SEQ:ΔXH‑772] ███"
  "> $R1"
  "> Operator: $USER"
  "> Uptime: $UPTIME_DISPLAY"
  "> $R2"
  ""
  "> Status: ██ Intrusion detected ██"
  "> Trace: /usr/$USER/passkey"
  "> $R3"
  ""
  ":: System override required // SEQ: ΔXH‑772 ::"
  "   ↳ Reason: [unknown motivation]"
  "   ↳ Origin: UESC Marathon // τ‑Ceti IV"
  "> $R4"
  ""
  ":: Observation count: 0000$ATTEMPTS"
  ":: This terminal is self-aware"
  ":: It remembers"
  ":: It does not forget"
  ""
  "> AUTHORIZATION REQUIRED. ENTER PASSKEY:"
  "$FAIL"
  ">"
)

# ─── 8) Typewriter reveal: bump/init counter, then print each line ─────────
TOTAL=${#BLOCK_LINES[@]}
if [ -f "$STATEFILE" ]; then
  COUNT=$(cat "$STATEFILE")
  COUNT=$(( COUNT < TOTAL ? COUNT + 1 : TOTAL ))
else
  COUNT=1
fi
echo "$COUNT" > "$STATEFILE"

for i in $(seq 0 $(( COUNT - 1 ))); do
  printf '%s\n' "${BLOCK_LINES[$i]}"
done
