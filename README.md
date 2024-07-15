# jsonpath

A command-line tool for manipulating JSON using JSONPath.

## Getting Started

- [Using jsonpath from the command line.](#usage)
- [Installing jsonpath](#installation)
- [New to JSONPath?  Read this.](#what-is-jsonpath)

## Usage

Applying a JSONPath query on a file
``` sh
% jsonpath '$.store.book[*].author' sample.json -p

[
    "Nigel Rees",
    "Evelyn Waugh",
    "Herman Melville",
    "J. R. R. Tolkien"
]
```

Viewing path to matching results
``` sh
% jsonpath '$.store.book[*].author' sample.json -lp
[
    "$['store']['book'][0]['author']",
    "$['store']['book'][1]['author']",
    "$['store']['book'][2]['author']",
    "$['store']['book'][3]['author']"
]
```

Getting help with arguments and options
``` sh
% jsonpath help simple

OVERVIEW: Simplified interface to quickly run a JSONPath query against a file

USAGE: jsonpath simple <query> <input> [-l] [-p]

ARGUMENTS:
  <query>                 JSONPath query
  <input>                 input file

OPTIONS:
  -l                      Output the path to the results instead of the results
                          themselves
  -p                      Pretty print the result JSON
  -h, --help              Show help information.
```

## Installation

### [Mint](https://github.com/yonaskolb/mint)
```
mint install KittyMac/jsonpath
```


## What is JSONPath

The original [Stefan Goessner JsonPath implemenentation](https://goessner.net/articles/JsonPath/) was released in 2007, and from it spawned dozens of different implementations. This [JSONPath Comparison](https://cburgmer.github.io/json-path-comparison/) chart shows the wide array of available implemenations, and at the time of this writing a Swift implementation is not present (note that there exists the [SwiftPath](https://github.com/g-mark/SwiftPath) project, but it is not included in said chart [due to critical errors when running on Linux](https://github.com/g-mark/SwiftPath/issues/15).

The rest of this section is largely adapted from the [Jayway JsonPath Getting Started](https://github.com/json-path/JsonPath#getting-started) section.

### Operators
---

| Operator                  | Description                                                     |
| :------------------------ | :-------------------------------------------------------------- |
| `$`                       | The root element to query. This starts all path expressions.    |
| `@`                       | The current node being processed by a filter predicate.         |
| `*`                       | Wildcard. Available anywhere a name or numeric are required.    |
| `..`                      | Deep scan. Available anywhere a name is required.               |
| `.<name>`                 | Dot-notated child                                               |
| `['<name>' (, '<name>')]` | Bracket-notated child or children                               |
| `[<number> (, <number>)]` | Array index or indexes                                          |
| `[start:end]`             | Array slice operator                                            |
| `[?(<expression>)]`       | Filter expression. Expression must evaluate to a boolean value. |


### Functions
---

Functions can be invoked at the tail end of a path - the input to a function is the output of the path expression.
The function output is dictated by the function itself.

| Function  | Description                                                        | Output type |     |
| :-------- | :----------------------------------------------------------------- | :---------- | --- |
| min()     | Provides the min value of an array of numbers                      | Double      |     |
| max()     | Provides the max value of an array of numbers                      | Double      |     |
| avg()     | Provides the average value of an array of numbers                  | Double      |     |
| stddev()  | Provides the standard deviation value of an array of numbers       | Double      |     |
| length()  | Provides the length of an array                                    | Integer     |     |
| sum()     | Provides the sum value of an array of numbers                      | Double      |     |
| keys()    | Provides the property keys (An alternative for terminal tilde `~`) | `Set<E>`    |     |
| concat(X) | Provides a concatinated version of the path output with a new item | like input  |     |
| append(X) | add an item to the json path output array                          | like input  |     |

### Filter Operators
---

Filters are logical expressions used to filter arrays. A typical filter would be `[?(@.age > 18)]` where `@` represents the current item being processed. More complex filters can be created with logical operators `&&` and `||`. String literals must be enclosed by single or double quotes (`[?(@.color == 'blue')]` or `[?(@.color == "blue")]`).   

| Operator | Description                                                        |
| :------- | :----------------------------------------------------------------- |
| ==       | left is equal to right (note that 1 is not equal to '1')           |
| !=       | left is not equal to right                                         |
| <        | left is less than right                                            |
| <=       | left is less or equal to right                                     |
| >        | left is greater than right                                         |
| >=       | left is greater than or equal to right                             |
| =~       | left matches regular expression  [?(@.name =~ /foo.*?/i)]          |
| in       | left exists in right [?(@.size in ['S', 'M'])]                     |
| nin      | left does not exists in right                                      |
| subsetof | left is a subset of right [?(@.sizes subsetof ['S', 'M', 'L'])]    |
| anyof    | left has an intersection with right [?(@.sizes anyof ['M', 'L'])]  |
| noneof   | left has no intersection with right [?(@.sizes noneof ['M', 'L'])] |
| size     | size of left (array or string) should match right                  |
| empty    | left (array or string) should be empty                             |


### Path Examples
---

Given the json

```javascript
{
  "store": {
    "book": [
      {
        "category": "reference",
        "author": "Nigel Rees",
        "title": "Sayings of the Century",
        "display-price": 8.95,
        "bargain": true
      },
      {
        "category": "fiction",
        "author": "Evelyn Waugh",
        "title": "Sword of Honour",
        "display-price": 12.99,
        "bargain": false
      },
      {
        "category": "fiction",
        "author": "Herman Melville",
        "title": "Moby Dick",
        "isbn": "0-553-21311-3",
        "display-price": 8.99,
        "bargain": true
      },
      {
        "category": "fiction",
        "author": "J. R. R. Tolkien",
        "title": "The Lord of the Rings",
        "isbn": "0-395-19395-8",
        "display-price": 22.99,
        "bargain": false
      }
    ],
    "bicycle": {
      "color": "red",
      "display-price": 19.95,
      "foo:bar": "fooBar",
      "dot.notation": "new",
      "dash-notation": "dashes"
    }
  }
}
```

| JsonPath (click link to try)| Result |
| :------- | :----- |
| <a href="https://www.swift-linux.com/?example=0&path=0" target="_blank">$.store.book[*].author</a>| The authors of all books     |
| <a href="https://www.swift-linux.com/?example=0&path=1" target="_blank">$..['author','title']</a>                   | All authors and titles                         |
| <a href="https://www.swift-linux.com/?example=0&path=3" target="_blank">$.store.*</a>                  | All things, both books and bicycles  |
| <a href="https://www.swift-linux.com/?example=0&path=4" target="_blank">$.store..display-price</a>             | The price of everything         |
| <a href="https://www.swift-linux.com/?example=0&path=5" target="_blank">$..book[2]</a>                 | The third book                      |
| <a href="https://www.swift-linux.com/?example=0&path=6" target="_blank">$..book[-2]</a>                 | The second to last book            |
| <a href="https://www.swift-linux.com/?example=0&path=7" target="_blank">$..book[0,1]</a>               | The first two books               |
| <a href="https://www.swift-linux.com/?example=0&path=8" target="_blank">$..book[:2]</a>                | All books from index 0 (inclusive) until index 2 (exclusive) |
| <a href="https://www.swift-linux.com/?example=0&path=9" target="_blank">$..book[1:2]</a>                | All books from index 1 (inclusive) until index 2 (exclusive) |
| <a href="https://www.swift-linux.com/?example=0&path=10" target="_blank">$..book[-2:]</a>                | Last two books                   |
| <a href="https://www.swift-linux.com/?example=0&path=11" target="_blank">$..book[2:]</a>                | Book number two from tail          |
| <a href="https://www.swift-linux.com/?example=0&path=12" target="_blank">$..book[?(@.isbn)]</a>          | All books with an ISBN number         |
| <a href="https://www.swift-linux.com/?example=0&path=13" target="_blank">$.store.book[?(@.display-price < 10)]</a> | All books in store cheaper than 10  |
| <a href="https://www.swift-linux.com/?example=0&path=14" target="_blank">$..book[?(@.bargain == true)]</a> | All bargain books in store  |
| <a href="https://www.swift-linux.com/?example=0&path=15" target="_blank">$..book[?(@.author =~ /.*REES/i)]</a> | All books matching regex (ignore case)  |
| <a href="https://www.swift-linux.com/?example=0&path=16" target="_blank">$..*</a>                        | Give me every thing   
| <a href="https://www.swift-linux.com/?example=0&path=17" target="_blank">$..book.length()</a>                 | The number of books                      |

