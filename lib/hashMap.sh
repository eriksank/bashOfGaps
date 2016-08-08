function hashMap {

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
        local instructions="declare -A$gflag $name=("
        if ! equal $# 0 ; then
            local key=$1
            local colon=$2
            local value=$3
            shift 3
            exitIfNot $colon :
            local value=$(echo "$value" | sed 's/"/\\"/g')
            local item="[\"$key\"]=\"$value\""
            local instructions="$instructions $item"
            local i=0
            local m=0
            for token in $@ ; do
                ((i++))
                ((m=i % 4))
                case $m in
                    1) local comma="$token" ;;
                    2) local key="$token" ;;
                    3) local colon="$token" ;;
                    0) local value="$token" ;;
                esac
                if equal $m 0 ; then
                    exitIfNot $comma ,
                    exitIfNot $colon :
                    local value=$(echo "$value" | sed 's/"/\\"/g')
                    local item="[\"$key\"]=\"$value\""
                    local instructions="$instructions $item"
                    local comma=""
                    local key=""
                    local colon=""
                    local value=""
                fi
            done
            if ! equal $m 0 ; then
                case $m in
                    1) stderr "unexpected ',' at end of hashMap data" ;;
                    2) stderr "':' expected after key '$key'" ;;
                    3) stderr "value expected after ':'" ;;
                esac            
                exit $_FALSE
            fi
        fi
        local prefix='declare -g'
        if equal $scope local ; then
            local prefix=local
        else
            local prefix=''
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
        fi
        required varName $1
        local varName=$1
        shift
        if ! equal $# 0 ; then
            exitIfNot $1 :=
            shift
        fi
        local name=$(dataStructure computeNewName hashMap)
        fromList $scope $varName $name "$@"
    }

    function embed {
        required firstArg $1
        local firstArg=$1
        if equal $firstArg local ; then
            local scope=local
            shift
        else
            local scope=''
        fi
        if ! equal $# 0 ; then
            exitIfNot $1 :=
            shift
        fi
        local name=$(dataStructure computeNewName hashMap)
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
        required key $2
        local key=$2
        derefKey $name $key
    }

    function set {
        required name $1
        local name=$1
        required key $2
        local key=$2
        required value $3
        local value="$3"
        eval $name[$key]="$value"
    }

    function keys {
        required name $1
        local name=$1
        eval echo "\${!$name[@]}"
    }

    function size {
        required name $1
        local name=$1
        eval echo \${#$name[@]}
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
        if ! dataStructure $name isHashMap; then
            stderr "'$name' is not a hashMap"
            exit 1
        fi
        $func $name "$@"
    fi
}

