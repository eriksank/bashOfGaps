function tHashMapEmbedDump1 {
    eval $(hashMap new local hmap := key1 : 12 , k2 : $(hashMap embed local := x1 : whatever1 , x2 : whatever2 , x3 : whatever3) , k3 : 45)
    local pattern=$(regexEscape '([k3]="45" [k2]="_hashMap_XXX_" [key1]="12" )')
    local pattern=${pattern//XXX/\\d+_\\d+_\\d+}
    assertMatch "$pattern" "$(hashMap $hmap dump)"
}

