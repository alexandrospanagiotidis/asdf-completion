#!/usr/bin/env bash

__asdf_complete() {
    local pluginName="${1}"
    shift

    local currentVersion
    currentVersion="$(asdf current "${pluginName}")"

    local loadedCompletionName="_ASDF_COMPLETE_${pluginName}_VER"

    if [[ ${!loadedCompletionName} != "${currentVersion}" ]]
    then
        _asdf_load_completion
        printf -v "${loadedCompletionName}" "%s" "${currentVersion}"
    fi

    _asdf_complete "${@}"
}

_asdf_complete_kubectl() {
    _asdf_complete() {
        __start_kubectl "${@}"
    }

    _asdf_load_completion() {
        source <(kubectl completion bash)
        complete -F _asdf_complete_kubectl kubectl
    }

    __asdf_complete "kubectl" "${@}"
}

complete -F _asdf_complete_kubectl kubectl
