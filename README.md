# bashOfGaps: Bash extension for nested arrays and json parsing

_Warning: Very incomplete documentation._

## 1. Trying out

For the time being, you may run `./test.sh` which will run all the existing unit tests.

## 2. ArrayList and hashTable

The project currently implements most of the functionality needed for a nestable `arrayList` and `hashTable`.

*arrayList.* Example: [ 1, "hello", 454, -4, "something" ]

An arrayList also often called a "vector".

*hashtable.* Example: { "id":12, "name":"John Doe", "birthdate":"12-JAN-2001" }

A hashtable is often also called a "map" or an "object" (in javascript) or an associative array (in php).

## 3. Why this project?

Bash implements arrayLists and hashTables. However, you cannot nest them. For example, out of the box, this structure cannot be stored in Bash:

	x={ "id":12, "name":"John Doe", "birthdate":"12-JAN-2001", 
		"orders":[ {"id":343, "date":"1-JAN-2015"}, {"id":675, "date":"2-MAR-2016"}] 
	}

## 4. Automating the solution

Of course, there is a trivial workaround:

	x={ "id":12, "name":"John Doe", "birthdate":"12-JAN-2001", "orders": "_arrayList_12232_8989_" }

	_arrayList_12232_8989_=[ {"id":343, "date":"1-JAN-2015"}, {"id":675, "date":"2-MAR-2016"}]


By looking at the key "orders", we can see that it possibly refers to an arraylist ("\_arrayList\_12232\_8989\_"). If this variable also really exists, then it is an embedded arrayList.

## 5. Classes in the project

* `dataStructure` contain the functions common to both `arrayList` and `hashTable`
* `arrayList` contains the arrayList functions
* `hashTable` contains the hashTable functions
* `util` contains a few utility functions

## 6. Current state of the project

Most functions have been implemented already, except for `clone`, `remove`(key) and `delete` (object).

The purpose is to use it to parse json files and be able to process them in bash.

## 7. Existing file structure

The current structure of the files looks like this:

```
	bashOfGaps $ tree .
	.
	├── dataStructure.sh
	├── lib
	│   ├── arrayList.sh
	│   ├── dataStructure.sh
	│   ├── hashMap.sh
	│   └── util.sh
	├── LICENSE
	├── README.md
	├── test
	│   ├── arrayList
	│   │   ├── arrayList.append.sh
	│   │   ├── arrayList.copyFrom.sh
	│   │   ├── arrayList.embed.sh
	│   │   ├── arrayList.get.sh
	│   │   ├── arrayList.keys.sh
	│   │   ├── arrayList.new.dump.sh
	│   │   ├── arrayList.set.sh
	│   │   └── arrayList.size.sh
	│   ├── dataStructure
	│   │   ├── computeNewName.sh
	│   │   ├── _dump.sh
	│   │   ├── isArrayList.sh
	│   │   ├── isBashArrayList.sh
	│   │   ├── isBashHashMap.sh
	│   │   ├── isDataStructure.sh
	│   │   ├── isDeclaredAs.sh
	│   │   ├── isHashMap.sh
	│   │   ├── isValidName.sh
	│   │   └── _keys.sh
	│   ├── hashMap
	│   │   ├── hashMap.copyFrom.sh
	│   │   ├── hashMap.embed.sh
	│   │   ├── hashMap.get.sh
	│   │   ├── hashMap.keys.sh
	│   │   ├── hashMap.new.dump.sh
	│   │   ├── hashMap.set.sh
	│   │   └── hashMap.size.sh
	│   └── util
	│       ├── derefKey.sh
	│       ├── deref.sh
	│       ├── empty.sh
	│       ├── isset.sh
	│       ├── map.sh
	│       ├── obliviousInput.sh
	│       ├── regexEscape.sh
	│       ├── required.sh
	│       ├── shutUp.sh
	│       ├── sortList.sh
	│       └── trim.sh
	├── test.sh
	└── todo.txt

	6 directories, 45 files
```

