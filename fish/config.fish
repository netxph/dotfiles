set -gx KIND_EXPERIMENTAL_PROVIDER podman

alias k kubectl

# Initialize zoxide's `z` and `zi` fish functions when zoxide is installed.
if type -q zoxide
    zoxide init fish | source
end
