# Maintainer: Ilaï Deutel <PlMWPh1WSmypRv0JQljz> (echo ... | tr 'A-Za-z' 'l-za-kL-ZA-K' | base64 -d)

pkgname=scc
pkgver=3.3.4
pkgrel=1
pkgdesc='Sloc, Cloc and Code: a very fast accurate code counter with complexity calculations and COCOMO estimates written in pure Go'
arch=('x86_64' 'i386')
url="https://github.com/boyter/scc"
license=('MIT' 'Unlicense')
depends=('glibc')
makedepends=('go')
source=("$pkgname-$pkgver::https://github.com/boyter/$pkgname/archive/v$pkgver.tar.gz")
sha256sums=('3097e23532d9a254fe217c81557136c7ac5aa4d48a200b61b366330e5eaf7ce4')

prepare(){
  cd "$pkgname-$pkgver"
  mkdir -p build/
}

build() {
  cd "$pkgname-$pkgver"
  export CGO_CPPFLAGS="${CPPFLAGS}"
  export CGO_CFLAGS="${CFLAGS}"
  export CGO_CXXFLAGS="${CXXFLAGS}"
  export CGO_LDFLAGS="${LDFLAGS}"
  export GOFLAGS="-buildmode=pie -trimpath -ldflags=-linkmode=external -mod=readonly -modcacherw"
  go build -o build ./...
}

check() {
  cd "$pkgname-$pkgver"
  go test ./...
}

package() {
  cd "$pkgname-$pkgver"
  install -Dm755 build/$pkgname "$pkgdir/usr/bin/$pkgname"
  install -Dm 644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
