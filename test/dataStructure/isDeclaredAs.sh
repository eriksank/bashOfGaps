function tIsDeclaredAs1 {
    eval $(arrayList new local aList := a b c d)
    dataStructure $aList isDeclaredAs a
    assertEqual $? 0
}

function tIsDeclaredAs2 {
    eval $(hashMap new local hMap := hello : a , whatever : b , andsome : hello)
    dataStructure $hMap isDeclaredAs A
    assertEqual $? 0
}

function tIsDeclaredAs3 {
    local x=hello
    shutUp dataStructure $x isDeclaredAs A
    assertEqual $? 1
}


