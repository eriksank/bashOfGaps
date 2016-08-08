function tComputeNewName1 {
    local name=$(dataStructure computeNewName arrayList)
    dataStructure $name isValidName arrayList
    assertEqual $? 0
}

