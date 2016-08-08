function tRequired1 {
    local x=199
    ( required x $x )
    assertEqual $? $_TRUE
}

function tRequired2 {
    local x=""
    ( shutUp required x $x )
    assertEqual $? $_FALSE
}

