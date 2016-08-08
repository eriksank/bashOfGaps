function tShutUp1 {
    local result=$(shutUp echo hello)
    empty $result
    assertEqual $? $_TRUE 
}

