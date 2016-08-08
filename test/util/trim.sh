function tTrim1 {
    local v=$(trim " hello ")
    assertEqual $v hello
}

function tTrim2 {
    local v=$(echo " hello " | trim)
    assertEqual $v hello
}

