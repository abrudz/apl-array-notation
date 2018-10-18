 text←Serialise array;a;Quot;Brack;Encl;name;⎕IO;zero;trailshape;content;SubMat;Dia ⍝ Convert Array to text
 ⎕IO←1
 Quot←('^|''' '$'⎕R'&'''⍕)⍤1
 Encl←{(l↑⍺⍺),(¯1⊖l↑w),')]'['(['⍳⍺⍺]↑⍨-l←2+≢w←⎕FMT ⍵}
 Brack←{(⎕FMT'['Encl⍤2)⍣⍺⍺⊢⍵}
 SubMat←{(¯2+≢⍴⍵)Brack ⍺⍺ ⍵}
 Dia←{1⌽')(',' *⋄ *$' ' *⋄ *(⋄ *)?' '([[(]) *⋄ *'⎕R'' ' ⋄ ' '\1'⍣≡∊↓'⋄',⍨⍵}⍣(2≥⊃⌽⍴array)
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
                 text,←⊂(name,':')(Serialise array⍎name)
             :Else
                 'Unsupported array'⎕SIGNAL 11
             :EndSelect
         :EndFor
         text←⎕FMT⍪text,')'
     :Else ⍝ num
         text←⍕array
     :EndSelect
 :ElseIf ⍬≡⍴array ⍝ enclosure
     text←⎕FMT'⊂'(Serialise⊃array)
 :ElseIf 0=≢array ⍝ no major cells
     :Select array
     :Case ⍬
         text←'⍬'
     :Case ''
         text←''''''
     :Else
         text←(⍕⍴array),'⍴⊂',Serialise⊃array
     :EndSelect
 :ElseIf 1=≢⍴array ⍝ non-empty vec
     :If 326=⎕DR array ⍝ heterovec
         text←'('Encl⍪Dia∘Serialise¨array
     :ElseIf 2|⎕DR array ⍝ charvec
         text←⍕array
     :Else ⍝ numvec
         text←Quot array
     :EndIf
     text←⎕FMT⍣(1≡≢array)⊢text
 :ElseIf 0∊¯1↓⍴array ⍝ early 0 length
     zero←¯1+0⍳⍨⍴array
     trailshape←zero↓⍴array
     content←(⍕trailshape),'⍴⊂',Serialise⊃array
     text←zero Brack(1,⍨zero↑⍴array)⍴⊂content
 :Else ⍝ high-rank
     :Select 10|⎕DR array
     :CaseList 0 2 ⍝ charmat
         text←Quot SubMat array
     :Case 6  ⍝ heteromat
         text←⎕FMT Dia∘Serialise¨array
     :Else ⍝ nummat
         :If ⍬≡array
         :ElseIf (1↑⍨-≢⍴array)≡0=⍴array
             text←('⍬'⍴⍨1,⍨¯1↓⍴)SubMat array
         :Else
             text←Serialise⍤1 SubMat array
         :EndIf
     :EndSelect
     text←'['Encl text
 :EndIf
