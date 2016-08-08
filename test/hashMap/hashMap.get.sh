function tHashMapGet1 {
    eval $(hashMap new local hmap := k1 : v1 , k2 : v2 , k3 : v3 , k4 : v4 , k5 : v5 )
    assertEqual $(hashMap $hmap get k2) v2
}

function tHashMapGet2 {
    eval $(hashMap new local hmap := k1 : v1 , k2 : v2 , k3 : v3 , k4 : v4 , k5 : v5 )
    assertEqual $(hashMap $hmap get k7) ""
}

function tHashMapGet3 {
    eval $(hashMap new local hmap)
    assertEqual $(hashMap $hmap get whateverkey) ""
}

