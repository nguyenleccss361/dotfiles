#!/bin/bash

# Start the service
systemctl --user start kanata-office.service

# Wait a moment to allow the service to start
sleep 1

# Check the service status
status=$(systemctl --user status kanata-office.service --no-pager)

# Check if the service is active (not failed)
if echo "$status" | grep -q "Active: active (running)"; then
  # Success notification
  dunstify -u normal "Kanata Service" "The service started successfully"
else
  # Failure notification with the error message from status
  # Capture all lines after the "sh" process start (without relying on PID)
  error_message=$(echo "$status" | grep -A 10 "sh" | tail -n 10 | sed 's/^\s*//') # Adjusting the error capture
  # Check for specific errors in the message to add more context
  if echo "$error_message" | grep -q "failed to parse file"; then
    dunstify -u critical "Kanata Service" "Failed to start the service. Error: $error_message"
  else
    # General failure notification
    dunstify -u critical "Kanata Service" "Failed to start the service. Error: Unknown"
  fi
fi
