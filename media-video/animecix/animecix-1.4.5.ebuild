# Copyright 2026 veilzon
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
adler2@2.0.1
aead@0.5.2
aes@0.8.4
aes-gcm@0.10.3
aho-corasick@1.1.5
alloc-no-stdlib@2.0.4
alloc-stdlib@0.2.4
allocator-api2@0.2.21
atomic-waker@1.1.2
autocfg@1.5.1
base64@0.22.1
bindgen@0.72.1
bitflags@2.13.1
block-buffer@0.10.4
brotli@8.0.4
brotli-decompressor@5.0.3
btls@0.5.6
btls-sys@0.5.6
bumpalo@3.20.3
bytes@1.12.1
cairo-rs@0.19.4
cairo-sys-rs@0.19.2
cc@1.4.2
cexpr@0.6.0
cfg-expr@0.15.8
cfg-if@1.0.4
cfg_aliases@0.2.1
chacha20@0.10.1
cipher@0.4.4
clang-sys@1.9.1
cmake@0.1.58
cpufeatures@0.2.17
cpufeatures@0.3.0
crc32fast@1.5.1
crypto-common@0.1.7
ctr@0.9.2
digest@0.10.7
displaydoc@0.2.7
either@1.18.0
equivalent@1.0.2
field-offset@0.3.6
find-msvc-tools@0.1.10
flate2@1.1.9
fnv@1.0.7
foldhash@0.2.0
foreign-types@0.5.0
foreign-types-macros@0.2.4
foreign-types-shared@0.3.1
form_urlencoded@1.2.2
fs_extra@1.3.0
fslock@0.2.1
futures-channel@0.3.34
futures-core@0.3.34
futures-executor@0.3.34
futures-io@0.3.34
futures-macro@0.3.34
futures-sink@0.3.34
futures-task@0.3.34
futures-util@0.3.34
gdk-pixbuf@0.19.8
gdk-pixbuf-sys@0.19.8
gdk4@0.8.2
gdk4-sys@0.8.2
generic-array@0.14.7
getrandom@0.2.17
getrandom@0.4.3
ghash@0.5.1
gio@0.19.8
gio-sys@0.19.8
glib@0.19.9
glib-macros@0.19.9
glib-sys@0.19.8
glob@0.3.4
gobject-sys@0.19.8
graphene-rs@0.19.8
graphene-sys@0.19.8
gsk4@0.8.2
gsk4-sys@0.8.2
gtk4@0.8.2
gtk4-macros@0.8.2
gtk4-sys@0.8.2
hashbrown@0.17.1
heck@0.5.0
hmac@0.12.1
http@1.5.0
http-body@1.1.0
http-body-util@0.1.4
http2@0.5.20
httparse@1.10.1
hyper@1.11.0
hyper-rustls@0.27.9
hyper-util@0.1.20
icu_collections@2.2.0
icu_locale_core@2.2.0
icu_normalizer@2.2.0
icu_normalizer_data@2.2.0
icu_properties@2.2.0
icu_properties_data@2.2.0
icu_provider@2.2.0
idna@1.1.0
idna_adapter@1.2.2
indexmap@2.14.0
inout@0.1.4
ipnet@2.12.1
itertools@0.13.0
itoa@1.0.18
jobserver@0.1.35
js-sys@0.3.104
libadwaita@0.6.0
libadwaita-sys@0.6.0
libc@0.2.189
libloading@0.8.9
litemap@0.8.2
log@0.4.33
lru@0.18.2
lru-slab@0.1.2
memchr@2.8.3
memoffset@0.9.1
minimal-lexical@0.2.1
miniz_oxide@0.8.9
mio@1.2.2
nom@7.1.3
once_cell@1.21.4
opaque-debug@0.3.1
openssl-macros@0.1.1
pango@0.19.8
pango-sys@0.19.8
percent-encoding@2.3.2
pin-project-lite@0.2.17
pkg-config@0.3.33
polyval@0.6.2
potential_utf@0.1.5
proc-macro-crate@3.5.0
proc-macro2@1.0.107
quinn@0.11.11
quinn-proto@0.11.17
quinn-udp@0.5.15
quote@1.0.47
r-efi@6.0.0
rand@0.10.2
rand_core@0.10.1
rand_core@0.6.4
rand_pcg@0.10.2
regex@1.13.1
regex-automata@0.4.18
regex-syntax@0.8.11
reqwest@0.12.28
ring@0.17.14
rustc-hash@2.1.3
rustc_version@0.4.1
rustls@0.23.46
rustls-pki-types@1.15.1
rustls-webpki@0.103.16
rustversion@1.0.23
ryu@1.0.23
semver@1.0.28
serde@1.0.229
serde_core@1.0.229
serde_derive@1.0.229
serde_json@1.0.151
serde_spanned@0.6.9
serde_urlencoded@0.7.1
sha2@0.10.9
shlex@1.3.0
shlex@2.0.1
simd-adler32@0.3.10
slab@0.4.12
smallvec@1.15.2
socket2@0.6.5
stable_deref_trait@1.2.1
subtle@2.6.1
syn@2.0.119
syn@3.0.3
sync_wrapper@1.0.2
synstructure@0.13.2
system-deps@6.2.2
target-lexicon@0.12.16
thiserror@1.0.69
thiserror@2.0.20
thiserror-impl@1.0.69
thiserror-impl@2.0.20
tinystr@0.8.3
tinyvec@1.12.0
tinyvec_macros@0.1.1
tokio@1.53.3
tokio-btls@0.5.6
tokio-rustls@0.26.4
tokio-util@0.7.19
toml@0.8.2
toml_datetime@0.6.3
toml_datetime@1.1.1+spec-1.1.0
toml_edit@0.20.2
toml_edit@0.25.13+spec-1.1.0
toml_parser@1.1.3+spec-1.1.0
tower@0.5.3
tower-http@0.6.11
tower-layer@0.3.3
tower-service@0.3.3
tracing@0.1.44
tracing-core@0.1.36
try-lock@0.2.5
typed-builder@0.23.2
typed-builder-macro@0.23.2
typenum@1.20.1
unicode-ident@1.0.24
universal-hash@0.5.1
untrusted@0.9.0
url@2.5.8
utf8_iter@1.0.4
version-compare@0.2.1
version_check@0.9.5
want@0.3.1
wasi@0.11.1+wasi-snapshot-preview1
wasm-bindgen@0.2.127
wasm-bindgen-futures@0.4.77
wasm-bindgen-macro@0.2.127
wasm-bindgen-macro-support@0.2.127
wasm-bindgen-shared@0.2.127
wasm-streams@0.4.2
web-sys@0.3.104
web-time@1.1.0
webpki-root-certs@1.0.10
webpki-roots@1.0.10
winapi@0.3.9
winapi-i686-pc-windows-gnu@0.4.0
winapi-x86_64-pc-windows-gnu@0.4.0
windows-link@0.2.1
windows-sys@0.52.0
windows-sys@0.61.2
windows-targets@0.52.6
windows_aarch64_gnullvm@0.52.6
windows_aarch64_msvc@0.52.6
windows_i686_gnu@0.52.6
windows_i686_gnullvm@0.52.6
windows_i686_msvc@0.52.6
windows_x86_64_gnu@0.52.6
windows_x86_64_gnullvm@0.52.6
windows_x86_64_msvc@0.52.6
winnow@0.5.40
winnow@1.0.4
wreq@6.0.0-rc.31
wreq-proto@0.2.6
wreq-rt@0.2.2-rc.4
wreq-util@3.0.0-rc.14
writeable@0.6.3
yoke@0.8.3
yoke-derive@0.8.2
zerofrom@0.1.8
zerofrom-derive@0.1.7
zeroize@1.9.0
zerotrie@0.2.4
zerovec@0.11.6
zerovec-derive@0.11.3
zmij@1.0.23
zstd@0.13.4
zstd-safe@7.4.0
zstd-sys@2.1.2+zstd.1.5.7
"

inherit cargo desktop

DESCRIPTION="Türkçe anime izleme uygulaması (GTK4/libadwaita + mpv)"
HOMEPAGE="https://github.com/veilzon/animecix-linux"
SRC_URI="https://github.com/veilzon/animecix-linux/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/DrewCyber/yggstack-ng/releases/download/v0.0.5/yggstack-linux-amd64 -> yggstack-linux-amd64-0.0.5
	${CARGO_CRATE_URIS}"
S="${WORKDIR}/animecix-linux-${PV}"

LICENSE="MIT CC-BY-SA-3.0 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-libs/gtk:4
	gui-libs/libadwaita
	media-libs/alsa-lib
	media-video/mpv[libmpv]
	net-misc/aria2
"
DEPEND="${RDEPEND}"
BDEPEND="
	${RUST_DEPEND}
	dev-build/cmake
	llvm-core/clang
	dev-lang/perl
	dev-lang/nasm
	sys-libs/zlib
"

src_compile() {
	cargo_src_compile
}

src_install() {
	dobin "$(cargo_target_dir)/animecix"
	dobin "$(cargo_target_dir)/animecix-calendar"
	newbin "${DISTDIR}/yggstack-linux-amd64-0.0.5" yggstack

	domenu "${FILESDIR}/tr.com.animecix.desktop"

	insinto /usr/share/metainfo
	doins packaging/flatpak/io.github.veilzon.AnimeciX.metainfo.xml

	local size
	for size in 64 128 256 512; do
		newicon -s "${size}" "assets/icon-${size}.png" tr.com.animecix.png
	done

	insinto /usr/share/licenses/${PN}
	doins LICENSE
	newins assets/fonts/OFL.txt Montserrat-OFL.txt
	newins assets/ATTRIBUTION-Adwaita.md Adwaita-ATTRIBUTION.md
	newins assets/ATTRIBUTION-yggstack.md yggstack-ATTRIBUTION.md

	insinto /usr/share/animecix
	doins assets/ATTRIBUTION-Adwaita.md
	cp -r assets/upscale assets/hicolor assets/changelog "${ED}/usr/share/animecix/" || die

	exeinto /usr/share/animecix
	doexe packaging/post-install-cleanup.sh packaging/post-remove-cleanup.sh
}

QA_PREBUILT="usr/bin/yggstack"

pkg_postinst() {
	sh "${EROOT}/usr/share/animecix/post-install-cleanup.sh" || :
}

pkg_prerm() {
	[[ -n "${REPLACED_BY_VERSION}" ]] && return
	sh "${EROOT}/usr/share/animecix/post-remove-cleanup.sh" remove || :
}
