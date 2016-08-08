function filePathExpandPWD {
    local path=$(dirname $1)
    if [ "$path" = "." ] ; then
        echo $PWD
    else
        echo $path
    fi
}

_thisDir=$(filePathExpandPWD $(dirname $0))
_libDir=$_thisDir/lib

for libScript in $_libDir/*.sh ; do
    source $libScript
done

