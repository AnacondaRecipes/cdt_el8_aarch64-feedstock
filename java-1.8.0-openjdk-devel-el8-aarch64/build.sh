#!/bin/bash
set -x

mkdir -p ${PREFIX}/aarch64-conda_el8-linux-gnu/sysroot
mkdir -p ${PREFIX}/aarch64-conda-linux-gnu/sysroot
if [[ -d usr/lib ]]; then
  if [[ ! -d lib ]]; then
    ln -s usr/lib lib
  fi
fi
if [[ -d usr/lib64 ]]; then
  if [[ ! -d lib64 ]]; then
    ln -s usr/lib64 lib64
  fi
fi
pushd ${PREFIX}/aarch64-conda_el8-linux-gnu/sysroot > /dev/null 2>&1
cp -Rf "${SRC_DIR}"/binary/* .

# Update symlinks.
for sl in usr/share/systemtap/tapset/arm64/*.stp; do
  link=$(readlink ${sl})
  unlink ${sl}
  ln -s ${PREFIX}/aarch64-conda_el8-linux-gnu/sysroot${link} ${sl}
done


popd

pushd ${PREFIX}/aarch64-conda-linux-gnu/sysroot > /dev/null 2>&1
cp -Rf "${SRC_DIR}"/binary/* .

# Update symlinks.
for sl in usr/share/systemtap/tapset/arm64/*.stp; do
  link=$(readlink ${sl})
  unlink ${sl}
  ln -s ${PREFIX}/aarch64-conda-linux-gnu/sysroot${link} ${sl}
done

popd
