function tEmpty1 {
    local a=x
    empty a
    assertEqual $? $_FALSE
}

function tEmpty2 {
    empty ""
    assertEqual $? $_TRUE
}

