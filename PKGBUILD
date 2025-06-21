# Maintainer: Ali Haydar Sucu <alihaydarsucu@gmail.com>
pkgname=sucu
pkgver=0.3.0
pkgrel=1
pkgdesc="A command-line assistant for Arch Linux beginners"
arch=('any')
url="https://github.com/alihaydarsucu/sucu"
license=('MIT')
depends=(
  'bash' 'nload' 'neofetch' 'btop' 'iotop-c' 'util-linux'
  'procps-ng' 'systemd' 'iproute2' 'iputils' 'shadow'
  'pacman' 'coreutils' 'gawk' 'sed' 'grep'
)

source=("sucu" "LICENSE")
md5sums=('SKIP')

package() {
  install -Dm755 "$srcdir/sucu" "$pkgdir/usr/bin/sucu"
  install -Dm644 "$srcdir/LICENSE" "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}