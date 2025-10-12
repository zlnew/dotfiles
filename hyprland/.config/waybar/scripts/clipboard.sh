#!/usr/bin/env bash
COUNT=$(cliphist list | wc -l)
echo "{\"text\": \"$COUNT\", \"tooltip\": \"Clipboard history: $COUNT entries\"}"
