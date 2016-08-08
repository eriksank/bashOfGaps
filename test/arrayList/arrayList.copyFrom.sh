function tArrayListCopyFrom1 {
    eval $(arrayList new local arr1 := hello1 hello2 hello3 hello4 hello5)
    eval $(arrayList new local arr2)
    arrayList $arr2 copyFrom $arr1
    assertEqual "$(arrayList $arr1 dump)" "$(arrayList $arr2 dump)"
}

