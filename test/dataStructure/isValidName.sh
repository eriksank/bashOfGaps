function tIsValidName1 {
    dataStructure _arrayList_20246_17603_28199_ isValidName arrayList
    assertEqual $? $_TRUE
}

function tIsValidName2 {
    dataStructure _hashMap_3145_14665_31628_ isValidName hashMap
    assertEqual $? $_TRUE
}

function tIsValidName3 {
    dataStructure whatever isValidName hashMap
    assertEqual $? $_FALSE
}

