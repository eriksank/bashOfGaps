function tSortList {
    local list=$(sortList "1 4 3 0")
    assertEqual "$list" "0 1 3 4"
}

