#!/usr/bin/env -S /Users/anand/.local/bin/uv run --script

# /// script
# requires-python = ">=3.9"
# dependencies = [
#     "aw-client",
# ]
# ///

import os
from datetime import datetime, timezone

from aw_client import ActivityWatchClient


def get_nonafk_events(client, timeperiods):
    query = """afk_events = query_bucket(find_bucket("aw-watcher-afk_"));
window_events = query_bucket(find_bucket("aw-watcher-window_"));
window_events = filter_period_intersect(window_events, filter_keyvals(afk_events, "status", ["not-afk"]));
RETURN = merge_events_by_keys(window_events, ["app", "title"]);"""
    return client.query(query, timeperiods)[0]


def main():
    client = ActivityWatchClient("alerts-script")
    now = datetime.now(timezone.utc).astimezone()
    timeperiods = [(now.replace(hour=0, minute=0, second=0), now)]
    events = get_nonafk_events(client, timeperiods)

    total_time_secs = sum(event["duration"] for event in events)
    total_time_mins = total_time_secs / 60
    hours, minutes = divmod(total_time_mins, 60)
    minutes = round(minutes)
    print(f"Screen Time: {hours} hours {minutes} minutes")

    # show mac notification
    os.system(f"osascript -e 'display notification \"{hours} hours {minutes} minutes\" with title \"Screen Time\"'")


if __name__ == "__main__":
    main()
