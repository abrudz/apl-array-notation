# A model for a literal notation for most APL Array arrays

## How to use
```
]load apl-array-notation/*
Deserialise '[1 2 ⋄ 3 4]`
Deserialise '(a:{(+⌿⍵)÷≢⍵}' 'b:42)'
Deserialise '(1 2 3',(⎕UCS 10),'4 5)'
```

An optional left argument of 0 may be specified to return an APL expression which will generate the array rather than returning the array itself.
