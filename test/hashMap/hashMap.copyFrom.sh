function tHashMapCopyFrom1 {
    eval $(hashMap new local hmap1 := key1 : hello1 , key2 : hello2 , key3 : hello3 , key4 : hello4 , key5 : hello5)
    eval $(hashMap new local hmap2)
    hashMap $hmap2 copyFrom $hmap1
    assertEqual "$(hashMap $hmap1 dump)" "$(hashMap $hmap2 dump)"
}

