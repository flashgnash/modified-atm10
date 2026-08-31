#!/usr/bin/env bash
# Tag packwiz mod metafiles with side=client/both by diffing against an
# official server pack's mods folder.
#   usage: set-sides.sh <server-files.zip>
# Mods whose jar is absent from the server pack are marked side=client.
# Prints server-pack jars with no client counterpart (potential side=server adds).
set -euo pipefail

server_zip=$1
pack_root=$(dirname "$(dirname "$(readlink -f "$0")")")
cd "$pack_root"

server_jars=$(mktemp)
# tolerate an optional top-level folder inside the zip
unzip -l "$server_zip" | grep -oP 'mods/[^/]+\.jar$' | sed 's|.*/||' | sort -u > "$server_jars"

client_count=0
for toml in mods/*.pw.toml; do
    fname=$(grep -oP '^filename = "\K[^"]+' "$toml")
    if grep -qxF "$fname" "$server_jars"; then
        sed -i 's/^side = .*/side = "both"/' "$toml"
    else
        sed -i 's/^side = .*/side = "client"/' "$toml"
        client_count=$((client_count + 1))
        echo "client: $toml ($fname)"
    fi
done

for toml in shaderpacks/*.pw.toml resourcepacks/*.pw.toml; do
    [ -e "$toml" ] || continue
    sed -i 's/^side = .*/side = "client"/' "$toml"
done

echo "---"
echo "marked $client_count mods client-only"
echo "--- server jars with no client metafile (candidates for side=server):"
client_jars=$(mktemp)
grep -hoP '^filename = "\K[^"]+' mods/*.pw.toml | sort -u > "$client_jars"
comm -23 "$server_jars" "$client_jars"
rm -f "$server_jars" "$client_jars"
