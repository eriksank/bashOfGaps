function tF {
    local args=$(obliviousInput "$@")
    echo $args
}

function tObliviousInput1 {
    tF whatever1
    echo whatever2 | tF
}

