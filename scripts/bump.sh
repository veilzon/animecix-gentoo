#!/usr/bin/env bash
# AnimeciX Gentoo overlay sürüm yükseltme betiği.
#
# Kullanım:
#   ./scripts/bump.sh v1.4.6          # yeni ebuild + Manifest
#   ./scripts/bump.sh v1.4.6 --check  # yalnız üretip mevcut ebuild ile karşılaştır
set -euo pipefail

cd "$(dirname "$0")/.."

die() {
	echo "hata: $*" >&2
	exit 1
}

[[ $# -ge 1 && $# -le 2 ]] || die "kullanım: $0 vX.Y.Z [--check]"

TAG="$1"
CHECK="${2:-}"
[[ "$TAG" =~ ^v?[0-9]+\.[0-9]+\.[0-9]+$ ]] || die "geçersiz sürüm: $TAG"
TAG="v${TAG#v}"
PV="${TAG#v}"
[[ -z "$CHECK" || "$CHECK" == "--check" ]] || die "bilinmeyen seçenek: $CHECK"

PKGDIR="media-video/animecix"
EBUILD="${PKGDIR}/animecix-${PV}.ebuild"
TEMPLATE="scripts/templates/animecix.ebuild.in"
[[ -f "$TEMPLATE" ]] || die "şablon bulunamadı: $TEMPLATE"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

URL="https://github.com/veilzon/animecix-linux/archive/refs/tags/${TAG}.tar.gz"
echo "kaynak indiriliyor: $URL"
curl -fsSL "$URL" -o "$TMP/source.tar.gz"
tar -xOf "$TMP/source.tar.gz" "animecix-linux-${PV}/Cargo.lock" > "$TMP/Cargo.lock"
python3 scripts/gen_crates.py "$TMP/Cargo.lock" > "$TMP/crates.txt"

python3 - "$TEMPLATE" "$TMP/crates.txt" "$TMP/new.ebuild" <<'PY'
import sys
from pathlib import Path

template, crates, out = map(Path, sys.argv[1:])
text = template.read_text()
text = text.replace("@CRATES@", crates.read_text().rstrip("\n"))
out.write_text(text)
PY

if [[ "$CHECK" == "--check" ]]; then
	[[ -f "$EBUILD" ]] || die "karşılaştırılacak ebuild yok: $EBUILD"
	if diff -q "$EBUILD" "$TMP/new.ebuild" >/dev/null; then
		echo "ebuild güncel: $EBUILD"
	else
		diff -u "$EBUILD" "$TMP/new.ebuild" || true
		die "ebuild şablonla uyuşmuyor: $EBUILD"
	fi
	exit 0
fi

cp "$TMP/new.ebuild" "$EBUILD"
find "$PKGDIR" -maxdepth 1 -name 'animecix-*.ebuild' ! -name "animecix-${PV}.ebuild" -delete
echo "yazıldı: $EBUILD"

if command -v ebuild >/dev/null 2>&1; then
	(cd "$PKGDIR" && ebuild "animecix-${PV}.ebuild" manifest)
elif command -v podman >/dev/null 2>&1; then
	podman run --rm -v "$PWD:/repo:Z" -w "/repo/${PKGDIR}" \
		docker.io/gentoo/stage3:latest bash -lc \
		"emerge --sync >/dev/null && ebuild animecix-${PV}.ebuild manifest"
else
	die "ebuild veya podman bulunamadı; Manifest üretilemedi"
fi

echo "Manifest hazır: ${PKGDIR}/Manifest"
