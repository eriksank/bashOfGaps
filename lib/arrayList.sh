function arrayList {

    function fromList {
        required scope $1
        local scope=$1
        required varName $2
        local varName=$2
        required name $3
        local name=$3
        shift 3
        if ! equal $scope local ; then
            local gflag=g
        else
            local gflag=''
        fi
        local instructions="declare -a$gflag $name=("
        for i in $@ ; do
            local item=$(echo "$i" | sed 's/"/\\"/g')
            local instructions="$instructions \"$item\""
        done
        local prefix='declare -g'
        if equal $scope local ; then 
            local prefix=local
        fi
        local instructions="$instructions)"
        if ! equal $varName NONE ; then
            local instructions="$instructions; $prefix $varName=$name"
        fi
        echo "$instructions"
    }

    function new {
        required firstArg $1
        local firstArg=$1
        if equal $firstArg local ; then
            local scope=local
            shift
        else
            local scope=global
        fi
        required varName $1
        local varName=$1
        shift
        if ! equal $# 0 ; then
            exitIfNot $1 :=
            shift
        fi
        local name=$(dataStructure computeNewName arrayList)
        fromList $scope $varName $name "$@"
    }

    function embed {
        required firstArg $1
        local firstArg=$1
        if equal $firstArg local ; then
            local scope=local
            shift
        fi
        if ! equal $# 0 ; then
            exitIfNot $1 :=
            shift
        fi
        local name=$(dataStructure computeNewName arrayList)
        eval $(fromList $scope NONE $name "$@")
        echo $name
    }

    function dump {
        required name $1
        local name=$1
        dataStructure $name _dump
    }

    function get {
        required name $1
        local name=$1
        required index $2
        local index=$2
        derefKey $name $index
    }

    function set {
        required name $1
        local name=$1
        required index $2
        local index=$2
        required value $3
        local value="$3"
        eval $name[$index]="$value"
    }

    function append {
        required name $1
        local name=$1
        required value $2
        local value="$2"
        eval "$name+=(\"$value\")"
    }

    function size {
        required name $1
        local name=$1
        eval echo \${#$name[@]}
    }

    function keys {
        required name $1
        local name=$1
        eval echo "\${!$name[@]}"
    }

    function remove {
        required name $1
        local name=$1
        required index $2
        local index=$2
        dataStructure $name _remove
    }

    function copyFrom {
        required toName $1
        local toName=$1
        required fromName $2
        local fromName=$2
        dataStructure $toName _copyFrom $fromName
    }

    if equal $1 new ; then
        local func=$1
        shift
        $func "$@"
    elif equal $1 embed ; then
        local func=$1
        shift
        $func "$@"
    else
        local name=$1
        local func=$2
        shift 2
        if ! dataStructure $name isArrayList; then
            stderr "'$name' is not an arrayList"
            exit 1
        fi
        $func $name "$@"
    fi
}

