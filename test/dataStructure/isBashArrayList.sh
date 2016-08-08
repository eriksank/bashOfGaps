function tIsBashArrayList1 {
    declare -a bArr=('great' 4 'a' 'b' 'xy')
    dataStructure bArr isBashArrayList
    assertEqual $? 0
}

function tIsBashArrayList2 {
    local x=hello
    dataStructure x isBashArrayList
    assertEqual $? 1
}

function tIsBashArrayList3 {
    declare -A hMap=( [x1]='great' [x2]=4 [x3]='a' [x4]='b' [x5]='xy')
    dataStructure hMap isBashArrayList
    assertEqual $? 1
}

