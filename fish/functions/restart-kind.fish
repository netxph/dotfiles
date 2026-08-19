function restart-kind
    set -l name kind
    if test (count $argv) -gt 0
        set name $argv[1]
    end

    if not type -q kind
        echo "kind is not installed" >&2
        return 127
    end
    if not type -q podman
        echo "podman is not installed" >&2
        return 127
    end

    set -l clusters (kind get clusters 2>/dev/null)
    if string match -q -- "$name" $clusters
        set -l nodes (podman ps -aq --filter "label=io.x-k8s.kind.cluster=$name" --filter status=exited)
        if test (count $nodes) -gt 0
            podman start $nodes
        end
    else
        kind create cluster --name $name
    end
end
