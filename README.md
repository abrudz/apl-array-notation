# A model for a literal notation for most APL arrays

## How to use

First load the library with `]load apl-array-notation/*`.

### `Deserialise`

This takes a character array and evaluates it as array notation, returning the resulting array.

```apl
Deserialise '[1 2 ⋄ 3 4]'
Deserialise '(a:{(+⌿⍵)÷≢⍵}' 'b:42)'
Deserialise '(1 2 3',(⎕UCS 10),'4 5)'
```

An optional left argument of 0 may be specified to return an APL expression which will generate the array rather than returning the array itself.

### `Serialise`

This takes an array and returns a character vector of matrix representing the argument in array notation.

```apl
Serialise 2 2⍴⍳4
Serialise ⎕fix ':namespace' 'a←{(+⌿⍵)÷≢⍵}' 'b←42' ':endnamespace'
Serialise '(1 2 3)(4 5)'
```

An optional left argumen of 1 may be specified to force return of a vector by using `⋄` to fuse lines.

### `∆NS`

Extends `⎕NS` to allow a two-element right argument of names and values:

```apl
myns←∆NS ('name1' 'name2')(7 42)
'myns'∆NS ('name3' 'name4')('apl' 'dyalog')
```

### `∆NSinverse`

Takes a ref or name of a namespace and returns a two-element vector of names and values.
```
∆NSinverse myns
∆NSinverse 'myns'
```
