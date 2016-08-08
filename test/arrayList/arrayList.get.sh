function tArrayListGet1 {
    eval $(arrayList new local arr := 1 2 3 4 5)
    assertEqual $(arrayList $arr get 0) 1
}

function tArrayListGet2 {
    eval $(arrayList new local arr := 1 2 3 4 5)
    assertEqual $(arrayList $arr get 15) ""
}

