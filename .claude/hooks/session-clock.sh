#!/usr/bin/env bash
# Claude Code SessionStart hook: prints the event clock into the session so
# the assistant knows how close demo-video time and the close are.
# Times were baked in when Opportunity Hack created this repo
# (event fall-2026, timezone America/Phoenix). Safe to delete after the event.

DEMO_EPOCH=1794769200
CLOSE_EPOCH=1794776400
TZ_NAME="America/Phoenix"

now=$(date +%s)

left() {
  local s=$1
  if [ "$s" -le 0 ]; then echo "passed"; return; fi
  printf '%dh %02dm away' $((s / 3600)) $(((s % 3600) / 60))
}

echo "OHack clock: $(TZ="$TZ_NAME" date '+%a %b %d, %I:%M %p %Z')."
if [ "$CLOSE_EPOCH" -gt 0 ]; then
  echo "Demo video time (Sun Nov 15, 12:00 PM MST): $(left $((DEMO_EPOCH - now)))."
  echo "Hacking ends (Sun Nov 15, 2:00 PM MST): $(left $((CLOSE_EPOCH - now)))."
  if [ "$now" -ge "$DEMO_EPOCH" ] && [ "$now" -lt "$CLOSE_EPOCH" ]; then
    echo "It's demo-video time: stop adding features, record the demo, then submit on https://www.ohack.dev/hack/fall-2026/manageteam."
  elif [ "$now" -ge "$CLOSE_EPOCH" ]; then
    echo "Hacking has ended. Anything left is post-hackathon follow-through with the nonprofit."
  fi
else
  echo "Final-day times are on https://www.ohack.dev/hack/fall-2026 — start the demo video about two hours before hacking ends."
fi
exit 0
