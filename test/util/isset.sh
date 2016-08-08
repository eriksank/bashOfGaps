function tIsset1 {
    local var=35
    isset var
    assertEqual $? $_TRUE
}

function tIsset2 {
    isset xyz
    assertEqual $? $_FALSE
}

