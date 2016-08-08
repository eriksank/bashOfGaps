function tArrayListEmbedDump1 {
    eval $(arrayList new local arr := 12 $(arrayList embed local := whatever1 whatever2 whatever3) 45)
    local pattern=$(regexEscape '([0]="12" [1]="_arrayList_XXX_" [2]="45")')
    local pattern=${pattern//XXX/\\d+_\\d+_\\d+}
    assertMatch "$pattern" "$(arrayList $arr dump)"
}

