_TRUE=0
_FALSE=1

function required {
    local varName=$1
    local varValue=$2
    if empty $varName ; then 
        die "variable name required"
    fi
    if empty $varValue ; then 
        die "argument '$varName' required"        
    fi
}

function isset {
    required variable $1
    local variable=$1
    shutUp declare -p $variable
}

function equal {
    if [[ $1 = "" && $2 = "" ]] ; then
        return $_TRUE
    elif [[ ! $1 = "" && $2 = "" ]] ; then
        return $_FALSE
    elif [[ $1 = "" && ! $2 = "" ]] ; then
        return $_FALSE
    elif [ "$1" = "$2" ] ; then
        return $_TRUE
    else
        return $_FALSE
    fi
}

function empty {
    equal $1 ""
}

function map {
    required f $1
    local f="$1"
    shift
    local list="$1"
    shift
    for elem in $list; do
        ($f $elem "$@")
    done
}


function stderr {
    local func=${FUNCNAME[2]}
    if empty $func; then
        func="main"
    fi
    >&2 echo "$func: $@"
}

function die {
    local msg="$1"
    stderr "$msg"
    exit $_FALSE
}

function deref {
    eval echo "\$$1"
}

function derefKey {
    eval echo \${"$1[\"$2\"]"}
}

function obliviousInput {
    if [ ! -t 0 ]; then
        cat /dev/stdin
    else
        echo "$@"
    fi
}

function stringHasChar {
    local string="$1"
    local char="$2"
    while read char2 ; do
        if equal $char $char2 ; then
            return $_TRUE
        fi
    done < <(echo "$string" | fold -w1)
    return $_FALSE
}

function regexEscape {
#
    while IFS= read -r char ; do
        if stringHasChar '.^$+?()[{|\*' $char; then
            echo -n '\'
        fi
        echo -n "$char"
    done < <(obliviousInput "$@" | fold -w1)
    echo
}

function shutUp {
    obliviousInput "$@" | "$@" &> /dev/null
}

function exitIfNot {
    required value1 $1
    local supplied=$1
    local expected=$2
    if ! equal $supplied $expected ; then
        stderr "'$expected' expected instead of '$supplied'"
        exit $_FALSE
    fi
}

function trim {
    local leading='s/^[[:space:]]*//'
    local trailing='s/[[:space:]]*$//'
    obliviousInput "$@" | sed -e $leading -e $trailing
}

function sortList {
    obliviousInput "$@" | tr ' ' '\n' | sort | tr '\n' ' ' | { trim ; echo; }
}

