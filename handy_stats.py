#!/usr/bin/env python3
"""Daily character count for Handy dictation history."""
import sqlite3
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path

DB = Path.home() / "Library/Application Support/com.pais.handy/history.db"

con = sqlite3.connect(DB)
rows = con.execute(
    "SELECT timestamp, length(coalesce(post_processed_text, transcription_text)) FROM transcription_history"
).fetchall()
con.close()

daily: dict[str, int] = defaultdict(int)
for ts, chars in rows:
    day = datetime.fromtimestamp(ts, tz=timezone.utc).strftime("%Y-%m-%d")
    daily[day] += chars

print(f"{'Date':<12} {'Chars':>8}")
print("-" * 22)
for day in sorted(daily, reverse=True):
    print(f"{day:<12} {daily[day]:>8,}")
