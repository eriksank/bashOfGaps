function tDeref1 {
    local variable=25
    local varName="variable"
    assertEqual $(deref $varName) 25
}

