function tIsHashMap1 {
    eval $(arrayList new local aList := a b c d)
    dataStructure $aList isHashMap
    assertEqual $? 1
}

function tIsHashMap2 {
    eval $(hashMap new local hMap := hello : a , whatever : b , andsome : hello)
    dataStructure $hMap isHashMap
    assertEqual $? 0
}

function tIsHashMap3 {
    local x=hello
    dataStructure $x isHashMap
    assertEqual $? 1
}

