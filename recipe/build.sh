#!/bin/bash

# HACK: extend $CONDA_PREFIX/meson_cross_file that's created in
# https://github.com/conda-forge/ctng-compiler-activation-feedstock/blob/main/recipe/activate-gcc.sh
# https://github.com/conda-forge/clang-compiler-activation-feedstock/blob/main/recipe/activate-clang.sh
# to use host python; requires that [binaries] section is last in meson_cross_file
echo "python = '${PREFIX}/bin/python'" >> ${CONDA_PREFIX}/meson_cross_file.txt
cat ${CONDA_PREFIX}/meson_cross_file.txt

if [[ $target_platform == "osx-arm64" ]]; then
    sed -i.bak "s@\[properties\]@[properties]\nskip_sanity_check = true@g" ${CONDA_PREFIX}/meson_cross_file.txt
fi

python -m pip install . -vv --no-deps --no-build-isolation
