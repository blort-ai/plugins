#!/usr/bin/env bash
# Builds chatgpt/blort-chatgpt-plugin-v<version>.zip from chatgpt/plugin.json,
# chatgpt/mcp.json, and the logo and skills of the Claude plugin.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
version="$(node -p "require('$root/chatgpt/plugin.json').version")"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
cp "$root/chatgpt/plugin.json" "$root/chatgpt/mcp.json" "$root/claude/logo.png" "$work/"
cp -R "$root/claude/skills" "$work/skills"
rm -f "$root"/chatgpt/blort-chatgpt-plugin-v*.zip
(cd "$work" && python3 -m zipfile -c "$root/chatgpt/blort-chatgpt-plugin-v$version.zip" plugin.json mcp.json logo.png skills)
echo "chatgpt/blort-chatgpt-plugin-v$version.zip"
