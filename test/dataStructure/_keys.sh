function t_Keys1 {
    eval $(arrayList new local arr := great 4 ab)
    local keys=$(dataStructure $arr _keys)
    assertEqual "$keys" "0 1 2"
}

function t_Keys2 {
    eval $(hashMap new local hMap := hello : a , whatever : b , andsome : hello)
    local keys=$(dataStructure $hMap _keys)
    assertEqual "$keys" "whatever andsome hello"
}


