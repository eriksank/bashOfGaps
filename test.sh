#!/usr/bin/env bash

#-------------------------------------------
# imports
#-------------------------------------------

source dataStructure.sh

while read testScript ; do
    source $testScript
done < <(find $_thisDir/test -type f)

#-------------------------------------------
# func functions
#-------------------------------------------

function isFunc {
    required func $1
    local func=$1
    equal $(type -t $func) 'function'
}

#-------------------------------------------
# finders
#-------------------------------------------

function findToList {
    local list=""
    while read f; do
        if empty $list; then
            list=$f
        else
            list="$list $f"
        fi
    done < <(find $@)
    echo "$list"
}

function findTestFolders {
    findToList $_thisDir/test -mindepth 1 -type d
}

function findEntry {
    required item $1
    local item=$1
    shift
    while read f ; do 
        local baseName=$(basename $f)
        if equal $baseName $item ; then
            echo $f
            return $_TRUE
        fi
    done < <("$@" | tr ' ' '\n')
    return $_FALSE
}

function findTestFolder {
    required folderName $1
    local folderName=$1
    findEntry $folderName findTestFolders
    return $_FALSE
}

function findTestFile {
    required fileName $1
    local fileName=$1
    findEntry $fileName find $_thisDir/test -type f
    return $_FALSE
}

function linesToWords {
    cat /dev/stdin | tr '\n' ' '
}

function findFunc {
    required path $1
    local path=$1
    required recursive $2
    local recursive=$2
    if equal $recursive yes; then
        local option=-R
    else
        local option=''
    fi
    grep $option 'function .* {' $path | sed 's/.*function \(.*\) {/\1/' | linesToWords
}

#-------------------------------------------
# executors
#-------------------------------------------

function execFileTestCases {
    required filePath $1
    local filePath=$1
    local baseName=$(basename $filePath .sh)
    echo -- $baseName --
    for testFunc in $(findFunc $filePath no) ; do
        $testFunc
    done
}

function execFolderTestCases {
    required folderPath $1
    local folderPath=$1
    local baseName=$(basename $folderPath)
    echo ---------------------------
    echo $baseName
    echo ---------------------------
    local list=$(find $folderPath -type f)
    for f in $list; do
        execFileTestCases $f
    done
}

#-------------------------------------------
# usage
#-------------------------------------------

function usage {
    local baseName=$(basename $0)
    echo "usage:"
    echo "  $baseName : execute all tests"
    local testFolders=$(find test -mindepth 1 -type d -exec basename {} \; | tr '\n' ' ' )
    echo "  $baseName [folder] : just in one folder "
    echo "     [ $testFolders]" 
    echo "          [file]     : just in one file"
    echo "          [testcase] : just the one function"
    echo "test functions:"
    echo -n "   "
    findFunc $_thisDir/test yes
    echo
}

if equal $1 help ; then
    usage
    exit $_TRUE
fi

#-------------------------------------------
# assertEqual
#-------------------------------------------

function assertEqual {
    local val1="$1"
    local val2="$2"
    echo -n "   * ${FUNCNAME[1]} "
    if equal "$val1" "$val2" ; then
        echo OK
    else
        echo FAIL
    fi
}

#-------------------------------------------
# assertMatch
#-------------------------------------------

function assertMatch {
    local pattern="$1"
    local value="$2"
    echo -n "   * ${FUNCNAME[1]} "
    if echo "$value" | grep -qP "$pattern" ; then
        echo OK
    else
        echo FAIL
    fi
}


#-------------------------------------------
# acquire first arg
#-------------------------------------------

_testSet="$1"

#-------------------------------------------
# doing all tests
#-------------------------------------------

if empty $_testSet ; then
    map execFolderTestCases "$(findTestFolders | linesToWords)"
    exit 0
fi

#-------------------------------------------
# doing a folder of test cases
#-------------------------------------------

_folderPath=$(findTestFolder $_testSet)
if ! empty $_folderPath ; then
    execFolderTestCases $_folderPath
    exit $_TRUE
fi

#-------------------------------------------
# doing a file of test cases
#-------------------------------------------

_filePath=$(findTestFile $_testSet.sh)
if ! empty $_filePath ; then
    execFileTestCases $_filePath
    exit $_TRUE
fi

#-------------------------------------------
# doing one test case
#-------------------------------------------

if isFunc $_testSet ; then
    $_testSet
    exit $_TRUE
fi

#-------------------------------------------
# cannot find symbol
#-------------------------------------------

stderr "Cannot find symbol '$_testSet' as folder, file, or function"
exit $_FALSE

#-------------------------------------------

