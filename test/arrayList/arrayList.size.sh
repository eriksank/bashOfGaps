function tArrayListSize1 {
    eval $(arrayList new local arr := 1 2 3 4 5)
    assertEqual $(arrayList $arr size) 5
}

function tArrayListSize2 {
    eval $(arrayList new local arr)
    assertEqual $(arrayList $arr size) 0
}

