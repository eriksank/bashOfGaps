function tDump1 {
    eval $(arrayList new local arr := great 4 a b "xy")
    assertEqual "$(dataStructure $arr _dump)" '([0]="great" [1]="4" [2]="a" [3]="b" [4]="xy")'
}

function tDump2 {
    eval $(hashMap new local hmap := hello : a , whatever : b , andsome : hello)
    assertEqual "$(dataStructure $hmap _dump)" '([whatever]="b" [andsome]="hello" [hello]="a" )'
}

