function tHashMapSize1 {
    eval $(hashMap new local hmap := k1 : v1 , k2 : v2 , k3 : v3 , k4 : v4 , k5 : v5)
    assertEqual $(hashMap $hmap size) 5
}

function tHashMapSize2 {
    eval $(hashMap new local hmap)
    assertEqual $(hashMap $hmap size) 0
}

