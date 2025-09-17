#!/usr/bin/env bash

# Stage all changes
git add .

# List staged files
added_files=$(git diff --cached --name-only)
if [ -z "$added_files" ]; then
  echo "⚠️ No changes to commit. Aborting."
  exit 1
fi

echo "📄 Files staged for commit:"
echo "$added_files"

# Generate commit message using Gemini
commit_msg=$(git diff --cached | gemini --model gemini-2.5-flash --prompt "Generate a concise commit message:")

# Check if commit message is empty
if [ -z "$commit_msg" ]; then
  echo "❌ Commit message is empty. Aborting commit."
  exit 1
else
  echo -n "$commit_msg" | wl-copy
  echo "✅ Commit message copied to clipboard:"
  echo "------------------------------------------------"
  echo "$commit_msg"
  echo "------------------------------------------------"
fi
