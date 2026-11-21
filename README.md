# AnimeciX Gentoo Overlay

AnimeciX için resmî olmayan Gentoo overlay'i. Uygulama kaynaktan derlenir;
`animecix` ve `animecix-calendar` birlikte kurulur.

## Kurulum

```bash
sudo eselect repository add animecix git https://github.com/veilzon/animecix-gentoo.git
sudo emaint sync -r animecix
sudo mkdir -p /etc/portage/package.accept_keywords
echo 'media-video/animecix ~amd64' | sudo tee /etc/portage/package.accept_keywords/animecix
sudo emerge -av media-video/animecix
```

## Güncelleme

```bash
sudo emaint sync -r animecix
sudo emerge -avu media-video/animecix
```

## Kaldırma

```bash
sudo emerge -ac media-video/animecix
sudo eselect repository remove animecix
```

## Bağımlılıklar

- `gui-libs/gtk:4`
- `gui-libs/libadwaita`
- `media-video/mpv[libmpv]`
- `net-misc/aria2`

Derleme için Rust, CMake, Clang, Perl, NASM ve zlib gerekir.

## Sürüm yükseltme

Yeni bir AnimeciX tag'i yayınlandığında:

```bash
./scripts/bump.sh v1.4.6
```

Betik yeni ebuild'i oluşturur ve crate listesini `Cargo.lock`'tan yeniler.
`Manifest` üretimi CI'daki `Manifest` işiyle yapılır; yerelde Podman/Docker
çalıştırılmaz.

## Kapsam

Bu overlay resmî Gentoo ağacının parçası değildir. Paket `~amd64` olarak
işaretlidir; farklı mimarilerde test edilmemiştir.
