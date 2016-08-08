function tIsDataStructure1 {
    eval $(arrayList new local aList := a b c d)
    dataStructure $aList isDataStructure
    assertEqual $? 0
}

function tIsDataStructure2 {
    eval $(hashMap new local hMap := hello : a , whatever : b , andsome : hello)
    dataStructure $hMap isDataStructure
    assertEqual $? 0
}

function tIsDataStructure3 {
    local x=hello
    dataStructure $x isDataStructure
    assertEqual $? 1
}


