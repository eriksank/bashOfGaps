function tArrayListAppend1 {
    eval $(arrayList new local arr := 1 2 3 4 5)
    arrayList $arr append 6
    assertEqual "$(arrayList $arr dump)" '([0]="1" [1]="2" [2]="3" [3]="4" [4]="5" [5]="6")'
}

function tArrayListAppend2 {
    eval $(arrayList new local arr :=)
    arrayList $arr append something
    assertEqual "$(arrayList $arr dump)" '([0]="something")'
}

