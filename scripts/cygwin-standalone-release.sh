#!/bin/bash

set +e
set +o pipefail

release_files=$(ls -1 ./*.exe)

function add_deps_auto() {
    echo "finding dep for '${1}'"
    deps_list=$(ldd "${1}" | grep '=>' | grep -v '/cygdrive' | gawk '{ print $3 }' | sort | uniq)
    for dep in $deps_list; do
        echo "found dep '${dep}' for '${1}'"
        echo "${dep}" >> deps
        add_deps_auto "${dep}"
    done
}

for release_file in $release_files; do
    echo "process file '${release_file}'"
    echo "${release_file}" >> deps
    add_deps_auto "${release_file}"
done

for dep in $(< deps sort | uniq); do
    [[ ! -f $(basename "${dep}") ]] && cp "${dep}" .
done
rm -f deps

echo 'Done!'
