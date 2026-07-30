#!/usr/bin/env bash

set -euo pipefail

OWNER="Sonic-DE"
SRC_PKGS_DIR="../srcpkgs"

for pkgdir in "$SRC_PKGS_DIR"/*; do
    [[ -d "$pkgdir" ]] || continue
    [[ -L "$pkgdir" ]] && continue

    template="$pkgdir/template"
    [[ -f "$template" && -s "$template" ]] || continue

    pkgname=$(sed -n 's/^pkgname=\(.*\)$/\1/p' "$template")
    version=$(sed -n 's/^version=\(.*\)$/\1/p' "$template")

    [[ -n "$pkgname" ]] || continue
    [[ -n "$version" ]] || continue

    echo "Checking $pkgname..."

    # Prefer latest release tag
    if ! latest=$(git ls-remote --refs --tags \
            "https://github.com/${OWNER}/${pkgname}.git" 2>/dev/null \
        | awk -F'/' '{print $NF}' \
        | sed 's/^v//' \
        | grep -E '^[0-9]+(\.[0-9]+)+([.-][0-9A-Za-z]+)*$' \
        | sort -V \
        | tail -n1); then
        echo "  Repository not found, skipping."
        continue
    fi

    if [[ -z "$latest" ]]; then
        echo "  No tags found, skipping."
        continue
    fi

    # Remove leading v if template versions don't use it
    latest="${latest#v}"

    if [[ "$latest" == "$version" ]]; then
        echo "  Up to date."
        continue
    fi

    url="https://github.com/${OWNER}/${pkgname}/archive/refs/tags/${latest}.tar.gz"

    tmp=$(mktemp)

    if ! curl -LfsS "$url" -o "$tmp"; then
        echo "  Failed to download $url"
        rm -f "$tmp"
        continue
    fi

    checksum=$(sha256sum "$tmp" | awk '{print $1}')
    rm -f "$tmp"

    sed -Ei \
        -e "s|^version=.*|version=${latest}|" \
        -e "s|^revision=.*|revision=1|" \
        -e "s|^checksum=.*|checksum=${checksum}|" \
        "$template"

    echo "  Updated:"
    echo "    version : $version -> $latest"
    echo "    checksum: $checksum"
done

echo
echo "Finished."
