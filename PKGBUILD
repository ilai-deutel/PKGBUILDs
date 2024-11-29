# Maintainer: David Runge <dvzrv@archlinux.org>

pkgname=pypiserver
pkgver=2.3.2
pkgrel=2
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
sha512sums=('83e48cf55892affee04533e0e1bb17dfa79548cd3629d1a61dd8f84cad635eb220ebe4207d1ceebe939eea0953fa17ffe6e549a015a9d9d6f627c9041e5786d2')
b2sums=('7982c3fdb4cdb159e7450476a9f845825ad1d3bd1327fa125f978f1848f3a15d4d6d5f8676c8c050e25d49dd4a83e806496c863dd7f4d3e9005764b33e4a9a5e')
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
