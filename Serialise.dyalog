 text←Serialise array;a

 :Select ≡array
 :Case 0 ⍝ simple scalar
     :Select 10|⎕DR
     :CaseList 0 2  ⍝ char
         text←'''',array,''' '
     :CaseList 6    ⍝ ref

     :Else ⍝ num
         text←array,' '
     :EndSelect
 :Case 1 ⍝ simple array
     :Select ≢⍴array
     :Case 1 ⍝ vec
         :If 0=2|⎕DR array ⍝ charvec
             text←'^|''|$'⎕R'&'''⊢'array'
         :Else ⍝ num or hetero
             text←1⌽')(',('⋄',⍨Serialise)¨array
         :EndIf
     :Case 2 ⍝ mat
     :Else   ⍝ high-rank
     :EndSelect
 :Else ⍝ nested
     a←Serialise¨array


 :EndSelect
