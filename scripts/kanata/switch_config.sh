#!/bin/bash

# Function to check live reload status
check_live_reload() {
    # Look for the live reload success in the logs
    log_output=$(journalctl --user-unit kanata-office.service --since "1 minute ago" --no-pager)

    # Check if the log contains the live reload success message
    if echo "$log_output" | grep -q "Live reload successful"; then
        # Find the *.kbd config file (e.g., brick.kbd)
        config_file=$(find ./ -name "*.kbd" | head -n 1)

        if [[ -n "$config_file" ]]; then
            # Send success notification using dunst
            dunstify -u normal "Live Reload" "Live reload successful for config: $config_file"
        else
            # Notify if no config file is found
            dunstify -u critical "Error" "No .kbd config file found!"
        fi
    else
        # Notify if live reload did not succeed
        dunstify -u critical "Error" "Live reload failed! Check the logs for details."
    fi
}

# Listen to logs for the kanata-office.service and check for live reload success
journalctl --user-unit kanata-office.service -f | while read -r line; do
    # Check if the log contains the "Live reload successful" message
    if echo "$line" | grep -q "Live reload successful"; then
        # Trigger the check_live_reload function when the condition is met
        check_live_reload
    fi
done
