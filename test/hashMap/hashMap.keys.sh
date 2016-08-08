function tHashMapKeys1 {
    eval $(hashMap new local hmap := k1 : v1 , k2 : v2 , k3 : v3 , k4 : v4 , k5 : v5)
    assertEqual "$(hashMap $hmap keys | sortList)" "k1 k2 k3 k4 k5"
}

function tHashMapKeys2 {
    eval $(hashMap new local hmap := k1 : v1)
    local keys=$(hashMap $hmap keys)
    assertEqual "$keys" k1
}

function tHashMapKeys3 {
    eval $(hashMap new local hmap)
    local keys=$(hashMap $hmap keys)
    assertEqual "$keys" ""
}

