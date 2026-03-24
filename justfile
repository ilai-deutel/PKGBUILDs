alias b := build
alias c := clean
alias p := publish
alias u := upgrade

AUR_URL := 'aur@aur.archlinux.org:'
all_packages := `find . -maxdepth 1 -type d -not -name ".*" -not -name LICENSES -printf '%P\n' | sort | xargs`

list:
    @echo {{ all_packages }}

clean +packages=all_packages:
    find {{ packages }} \
      -mindepth 1 \
      -maxdepth 1 \
      -not -name .gitignore \
      -not -name .SRCINFO \
      -not -name *.install \
      -not -name .nvchecker.toml \
      -not -name *.patch \
      -not -name LICENSE \
      -not -name LICENSES \
      -not -name PKGBUILD \
      -not -name REUSE.toml \
      -not -name list-proxy-names.rs \
      -exec rm --recursive --verbose {} +

check package:
    namcap {{ package }}/PKGBUILD
    version=$(just extract {{ package }} pkgver); if epoch=$(just extract {{ package }} epoch 2>/dev/null); then version="$epoch:$version"; fi; namcap {{ package }}/"{{ package }}-$version"-*.pkg.*

build package: && (check package)
    makepkg --dir {{ package }} --syncdeps --install --force
    makepkg --dir {{ package }} --printsrcinfo > {{ package }}/.SRCINFO

upgrade package: && (build package)
    pkgctl version upgrade {{ package }}

check-version package:
    pkgctl version check {{ package }}

check-versions:
    echo {{ all_packages }} \
    | xargs -n1 \
    | grep -Ev '(^typst$|^python-xdg$|-git$)' \
    | xargs pkgctl version check

publish package:
    git subtree push --prefix {{ package }} "{{ AUR_URL }}/$(just extract {{ package }} pkgbase).git" master
    git push origin master

extract package key:
    #!/usr/bin/env bash
    src_info={{ package }}/.SRCINFO
    value=$(sed --quiet 's/\s*{{ key }} = //p' "${src_info}")
    if [[ -z "$value" ]]; then
      >&2 echo "Could not find key {{ key }} in ${src_info}"
      exit 1
    fi
    echo "$value"
