 text←Serialise array;a;Quot;Brack;Encl;name;⎕IO
 ⎕IO←1
 Quot←('^|''' '$'⎕R'&'''⍕)⍤1
 Encl←{(l↑⍺⍺),w,')]'['(['⍳⍺⍺]↑⍨-l←≢w←⎕FMT ⍵}
 :If 0=≡array ⍝ simple scalar
     :Select 10|⎕DR array
     :CaseList 0 2  ⍝ char
         text←'''',array,''''
     :CaseList 6    ⍝ ref
         text←'('
         :For name :In array.⎕NL-⍳9
             :Select array.⎕NC⊂name
             :CaseList 2.1 2.2 2.3 2.6 ⍝ var
                 text,←⊂⎕FMT(name,':')(Serialise array⍎name)
             :CaseList 3.2 4.2 ⍝ dfn/dop
                 text,←⊂↑('^( ',name,')←')⎕R'\1:'@1 array.⎕NR name
             :CaseList 9+0.1×⍳9
                 text,←⊂Serialise array⍎name
             :Else
                 'Unsupported array'⎕SIGNAL 11
             :EndSelect
         :EndFor
         text←⎕FMT⍪text,')'
     :Else ⍝ num
         text←⍕array
     :EndSelect
 :ElseIf 1=≢⍴array ⍝ non-atomic
       ⍝ vec
     :If 0=≢array
         :Select array
         :Case ⍬
             text←'⍬'
         :Case ''
             text←''''''
         :Else
             text←'0⍴⊂',Serialise⊃array
         :EndSelect
     :ElseIf 0 2∊⍨10|⎕DR array ⍝ charvec
         text←Quot array
     :ElseIf 2|⎕DR array  ⍝ numvec
         text←⍕array
     :Else ⍝ heterovec
         text←'('Encl∊('⋄',⍨Serialise)¨array
     :EndIf
     :else 2 ⍝ high-rank
         ⍝:Select 10|⎕DR array
 :CaseList 0 2 ⍝ charmat
     text←Quot array
 :Case 6  ⍝ heteromat
     text←⎕FMT Serialise¨array
 :Else ⍝ nummat
     :If ⍬≡array
     :ElseIf (1↑⍨-≢⍴array)≡0=⍴array
         text←(⎕FMT'['Encl⍤2)⍣(¯2+≢⍴array)⊢(1,⍨¯1↓⍴array)⍴'⍬'
     :ElseIf 0∊⍴array
         text←(⍕⍴array),'⍴⊂',Serialise⊃array
     :Else
         text←⎕FMT array
     :EndIf
 :EndSelect
 text←'['Encl text
     ⍝:Else   ⍝ high-rank
 :If (1↑⍨-≢⍴array)≡0=⍴array
     text←(⎕FMT'['Encl⍤2)⍣(¯1+≢⍴array)⊢(1,⍨¯1↓⍴array)⍴'⍬'
 :Else
     text←(⎕FMT'['Encl⍤3)⍣(¯1+≢⍴array)⊢Serialise⍤1⊢array
 :EndIf
 :EndIf
