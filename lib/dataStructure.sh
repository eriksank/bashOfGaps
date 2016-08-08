function dataStructure {

    function isDeclaredAs {
        required varName $1
        local varName=$1
        required declareOption $2
        local declareOption=$2
        [[ "$(declare -p $varName)" =~ "declare -$declareOption" ]]
    }

    function isBashArrayList {
        required varName $1
        local varName=$1
        isDeclaredAs $varName a
    }

    function isBashHashMap {
        required varName $1
        local varName=$1
        isDeclaredAs $varName A
    }

    function isValidName {
        required varName $1
        local varName=$1
        required type $2
        local type=$2
        [[ $varName =~ ^_"$type"_[[:digit:]]+_[[:digit:]]+_[[:digit:]]+_$ ]]
    }

    function computeNewName {

        function newName {
            required prefix $1
            local prefix=$1
            echo _${prefix}_${RANDOM}_${RANDOM}_${RANDOM}_
        }

        required prefix $1
        local prefix=$1
        local name=$(newName $prefix)
        #keep looking for a name that is not in use already
        while [[ -v $name ]] ; do
            local name=$(newName $prefix)
        done
        echo $name
    }

    function isArrayList {
        required name $1
        local name=$1
        isValidName $name arrayList && isBashArrayList $name 
    }

    function isHashMap {
        required name $1
        local name=$1
        isValidName $name hashMap && isBashHashMap $name 
    }

    function isDataStructure {
        required name $1
        local name=$1
        isArrayList $name || isHashMap $name
    }

    function _remove {
        required name $1
        local name=$1
        if isArrayList $name ; then
            map arrayList remove "$(_keys $name)"
        elif isHashMap $name ; then
            map hashMap remove "$(_keys $name)"
        else
            stderr "Not a valid data structure"
        fi
        unset $name
    }

    function _keys {
        required name $1
        local name=$1
        if isArrayList $name ; then
            arrayList $name keys
        elif isHashMap $name ; then
            hashMap $name keys
        else
            stderr "Not a valid data structure"
            exit $_FALSE
        fi
    }

    function _get {
        required name $1
        local name=$1
        required key $2
        local get=$2
        if isArrayList $name ; then
            arrayList $name get $key
        elif isHashMap $name ; then
            hashMap $name get $key
        else
            stderr "Not a valid data structure"
            exit $_FALSE
        fi
    }

    function _copyFrom {
        required toName $1
        local toName=$1
        required fromName $2
        local fromName=$2
        for key in $(keys $fromName); do
            dataStructure $toName set $key "$(dataStructure $fromName get $key)"
        done
    }

    function _dump {
        required name $1
        local name=$1
        IFS== read noise bashData < <(eval declare -p $name)
        echo "${bashData:1:-1}"
    }

    if equal $1 computeNewName ; then
        shift
        computeNewName "$@"
    else
        required name $1
        local name=$1
        shift
        required func $1
        local func=$1
        shift
        $func $name "$@"
    fi
}

