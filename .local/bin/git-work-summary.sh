#!/usr/bin/env bash
set -euo pipefail

# Prepare output folder
output_dir="$HOME/www/work-summary"
mkdir -p "$output_dir"

# Get current folder name and date for file naming
current_folder=$(basename "$PWD")
today=$(date +"%Y-%m-%d")
output_file="${output_dir}/${current_folder}-${today}.txt"

# Get current git user
author_name=$(git config user.name || true)

# Build since date (today 00:00 with timezone)
since_date="$(date +%Y-%m-%dT00:00:00%z)"
echo "📅 Using since: $since_date"

# Fetch logs (today only)
if [[ -n "$author_name" ]]; then
  logs=$(git log --since="$since_date" --author="$author_name" \
    --pretty=format:"%h - %an, %ar : %s" || true)
else
  logs=$(git log --since="$since_date" \
    --pretty=format:"%h - %an, %ar : %s" || true)
fi

# Fallback to yesterday if empty
if [[ -z "$logs" ]]; then
  echo "⚠️  No logs found for today (author: ${author_name:-ANY}), trying yesterday..."
  since_yesterday="$(date -d "yesterday" +%Y-%m-%dT00:00:00%z)"
  echo "📅 Using since: $since_yesterday"
  if [[ -n "$author_name" ]]; then
    logs=$(git log --since="$since_yesterday" --until="$since_date" --author="$author_name" \
      --pretty=format:"%h - %an, %ar : %s" || true)
  else
    logs=$(git log --since="$since_yesterday" --until="$since_date" \
      --pretty=format:"%h - %an, %ar : %s" || true)
  fi
fi

if [[ -z "$logs" ]]; then
  echo "⚠️  Still no logs found. Aborting."
  exit 1
fi

echo "📜 Git Logs (author: ${author_name:-ANY}):"
echo "$logs"

# Generate summary using Gemini
result=$(printf "%s\n" "$logs" | gemini --model gemini-2.5-flash \
  --prompt "Make a short, numbered-point list summarizing what I did based on these git logs.")

# Check and save result
if [[ -z "$result" ]]; then
  echo "❌ No summary generated. Aborting."
  exit 1
fi

echo "✅ Summary generated:"
echo "$result"

# Save to file (overwrite, or append if already exists)
echo "$result" >"$output_file"
echo "💾 Saved summary to: $output_file"
