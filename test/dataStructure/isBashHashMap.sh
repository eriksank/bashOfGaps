function tIsBashHashMap1 {
    declare -A hMap=( [x1]='great' [x2]=4 [x3]='a' [x4]='b' [x5]='xy')
    dataStructure hMap isBashHashMap
    assertEqual $? 0
}

function tIsBashHashMap2 {
    local x=hello
    dataStructure x isBashHashMap
    assertEqual $? 1
}

function tIsBashHashMap3 {
    declare -a bArr=('great' 4 'a' 'b' 'xy')
    dataStructure bArr isBashHashMap
    assertEqual $? 1
}

