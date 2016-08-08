function tArrayListKeys1 {
    eval $(arrayList new local arr := 1 2 3 4 5)
    assertEqual "$(arrayList $arr keys)" "0 1 2 3 4"
}

function tArrayListKeys2 {
    eval $(arrayList new local arr := 1)
    assertEqual "$(arrayList $arr keys)" "0"
}

function tArrayListKeys3 {
    eval $(arrayList new local arr)
    assertEqual "$(arrayList $arr keys)" ""
}

