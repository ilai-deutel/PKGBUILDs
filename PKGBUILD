# Maintainer: David Runge <dvzrv@archlinux.org>

pkgname=pypiserver
pkgver=2.4.0
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
sha512sums=('543f8bf98bface6a6db996c130be5acb19aa31ab85d5d37d9766e132b38713aed1eb0a46c67f767185409bf8c4eaef6fdfdcb5137af2651b5b6191032b5c5268')
b2sums=('99254c4cbc4290a80a2e272c1932f91e33aa7ee68a28463faf2dbad27fca505c52697aeaea812ae7aff6b0ee5e109d7c535f0d6c4bbe3af804de29a5ccabff53')
validpgpkeys=('0BFB950A1851C0E7EE46D9BCAF5C892A5573ABED') # Matthew Planchard (2020-06-22-mininix) <msplanchard@gmail.com>

prepare() {
  # extract dedicated license files
  sed -n '7,25p' $pkgname-$pkgver/LICENSE.txt > MIT.txt
  sed -n '30,49p' $pkgname-$pkgver/LICENSE.txt > Zlib.txt
}

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
  install -vDm 644 ../{MIT,Zlib}.txt -t "$pkgdir/usr/share/licenses/$pkgname/"
}
