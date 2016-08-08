function tIsArrayList1 {
    eval $(arrayList new local arr := great 4 a b "xy")
    dataStructure $arr isArrayList
    assertEqual $? 0
}

function tIsArrayList2 {
    local x=hello
    dataStructure $x isArrayList
    assertEqual $? 1
}

function tIsHashMap3 {
    eval $(hashMap new local hMap := hello : a , whatever : b , andsome : hello)
    dataStructure $hMap isArrayList
    assertEqual $? 1
}

