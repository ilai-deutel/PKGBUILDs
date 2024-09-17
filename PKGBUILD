# Maintainer: David Runge <dvzrv@archlinux.org>

pkgname=pypiserver
pkgver=2.2.0
pkgrel=1
pkgdesc="Minimal PyPI server for uploading and downloading packages with pip/easy_install"
arch=(any)
url="https://github.com/pypiserver/pypiserver"
license=(
  MIT
  Zlib
)
depends=(
  python
  python-pip
)
makedepends=(
  python-build
  python-installer
  python-setuptools
  python-setuptools-git
  python-wheel
)
checkdepends=(
  python-httpx
  python-passlib
  python-pip
  python-pytest
  python-watchdog
  python-webtest
)
optdepends=(
  'python-passlib: for authentication'
  'python-setuptools: for new - still inactive - config module'
  'python-waitress: for waitress support'
  'python-watchdog: for cache'
)
source=($pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz)
sha512sums=('e1c313b52c852b90ee3efe07b754d91ac842483718fe30f0c59951aad9aa84bc36c9264956fd931a98aaad5ee151089a06472f19e4ae5e9eb1d20c72cc98f436')
b2sums=('8c5e68201a4d376bc04ca8a5dc243c8c176f6a1bfd362fd5b0eb2875ca071cd124d15814312c2c14ded57c8476f72d41ccf1057eced2247d17f1cc6b7b12e86c')
validpgpkeys=('0BFB950A1851C0E7EE46D9BCAF5C892A5573ABED') # Matthew Planchard (2020-06-22-mininix) <msplanchard@gmail.com>

build() {
  cd $pkgname-$pkgver
  python -m build --wheel --no-isolation
}

check() {
  local site_packages=$(python -c "import site; print(site.getsitepackages()[0])")

  cd $pkgname-$pkgver
  python -m installer --destdir=test_dir dist/*.whl
  export PYTHONPATH="$PWD/test_dir/$site_packages:$PYTHONPATH"
  pytest -vv --ignore docker/test_docker.py -k "not test_twine"
}

package() {
  cd $pkgname-$pkgver
  python -m installer --destdir="$pkgdir" dist/$pkgname*.whl
  install -vDm 644 {AUTHORS,CHANGES}.rst README.md -t "$pkgdir/usr/share/doc/$pkgname/"
  install -vDm 644 LICENSE.txt -t "$pkgdir/usr/share/licenses/$pkgname/"
}
