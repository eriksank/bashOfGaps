function tArrayListNewDump1 {
    eval $(arrayList new local arr := 1 2 3 4 5)
    assertEqual "$(arrayList $arr dump)" '([0]="1" [1]="2" [2]="3" [3]="4" [4]="5")'
}

function tArrayListNewDump2 {
    eval $(arrayList new local arr)
    assertEqual "$(arrayList $arr dump)" '()'
}

function tArrayListNewDump3 {
    eval $(arrayList new local arr := 12)
    assertEqual "$(arrayList $arr dump)" '([0]="12")'
}

