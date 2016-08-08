function tHashMapNewDump1 {
    eval $(hashMap new local hmap :=  k1 : v1 , k2 : v2 , k3 : v3 , k4 : v4 , k5 : v5)
    assertEqual "$(hashMap $hmap dump)" '([k1]="v1" [k3]="v3" [k2]="v2" [k5]="v5" [k4]="v4" )'
}

function tHashMapNewDump2 {
    eval $(hashMap new local hmap)
    assertEqual "$(hashMap $hmap dump)" '()'
}

function tHashMapNewDump3 {
    eval $(hashMap new local hmap := k2 : v2)
    assertEqual "$(hashMap $hmap dump)" '([k2]="v2" )'
}

