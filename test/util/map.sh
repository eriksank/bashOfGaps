function tMap1 {
    local result=$(map echo "1 2 3" | tr '\n' ' ')
    assertEqual "$result" "1 2 3 "
}

function tMap2 {
    local result=$(map echo "" | tr '\n' ' ')
    assertEqual "$result" ""
}
