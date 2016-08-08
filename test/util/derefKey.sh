function tDerefKey1 {
    declare -a array=(a b c d)
    assertEqual $(derefKey array 2) c
}

function tDerefKey2 {
    declare -A map=([a]=val1 [b]=val2 [c]=val3)
    assertEqual $(derefKey map b) val2
}

