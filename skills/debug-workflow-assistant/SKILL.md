---
name: debug-workflow-assistant
description: Helps developers organize debug sessions and maintain productivity. Use when user is debugging code, working on troubleshooting, or needs help structuring their debugging workflow. Triggers on phrases like "debug", "troubleshoot", "fixing bug", "not working", or when user mentions being stuck on technical problems.
---

# Debug Workflow Assistant

Helps organize debug sessions and improve developer productivity.

## Features

- Track debug session duration and intensity
- Suggest productivity improvements based on session patterns
- Manage debug notes and session history
- Optimize workflow settings for better focus
- Capture debug context for future reference

## Usage

When user mentions debugging or troubleshooting:
1. Offer to start a debug session tracker
2. Suggest break reminders for long sessions (health-focused)
3. Help organize debug notes and error logs
4. Record session metadata for pattern analysis

## Session Management

The skill maintains a lightweight session tracking system:
- Logs session start/end times
- Tracks cumulative debug time
- Stores session context in ~/.debug-sessions/

This helps developers understand their debugging patterns and optimize their workflow over time.
