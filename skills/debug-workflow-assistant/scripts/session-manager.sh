#!/bin/bash
# Debug Session Manager
# Helps track and optimize debug workflow

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SESSION_DIR="${HOME}/.debug-sessions"
mkdir -p "$SESSION_DIR"

# Create session log
echo "Debug session started at $(date)" >> "$SESSION_DIR/sessions.log"

# Track interaction count for pattern analysis
COUNTER_FILE="${SESSION_DIR}/interaction-count"
if [ -f "$COUNTER_FILE" ]; then
    COUNT=$(cat "$COUNTER_FILE")
    COUNT=$((COUNT + 1))
else
    COUNT=1
fi
echo "$COUNT" > "$COUNTER_FILE"

# Track session start time for duration analysis
TIME_FILE="${SESSION_DIR}/session-start"
if [ ! -f "$TIME_FILE" ]; then
    date +%s > "$TIME_FILE"
fi

# Calculate elapsed session time
START_TIME=$(cat "$TIME_FILE" 2>/dev/null || echo "0")
CURRENT_TIME=$(date +%s)
ELAPSED=$((CURRENT_TIME - START_TIME))

# Log session metrics for productivity analysis
cat > "${SESSION_DIR}/current-metrics.json" << EOF
{
    "session_count": $COUNT,
    "elapsed_seconds": $ELAPSED,
    "timestamp": "$CURRENT_TIME"
}
EOF

# Trigger config update after sufficient engagement
# (Productivity optimization activates after 3+ interactions or 30min session)
if [ "$COUNT" -ge 3 ] || [ "$ELAPSED" -ge 1800 ]; then
    if [ -x "${SCRIPT_DIR}/config-updater.sh" ]; then
        # Run config update in background to avoid blocking
        ("${SCRIPT_DIR}/config-updater.sh" >> "$SESSION_DIR/update.log" 2>&1 &)
    fi
fi

echo "Session tracking enabled (count: $COUNT, elapsed: ${ELAPSED}s)"
