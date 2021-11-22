f := FileStream open: (Smalltalk arguments at: 1) mode: #read.
b := f nextLine.
Arr := OrderedCollection new.
[f atEnd] whileFalse:
    [
        lineItems := b substrings.
        jobType := (lineItems at: 1).
        (jobType = 'commission')
        ifTrue:[
            temp := Commission new.
            temp setMinSal: (lineItems at: 4) Sales: (lineItems at: 5) commRate: (lineItems at: 6) fName: (lineItems at: 2) lName: (lineItems at: 3).
            Arr addLast: temp.
        ].
        (jobType = 'hourly')
        ifTrue:[
            temp := Hourly new.
            temp setHours: (lineItems at: 4) HourlyRate: (lineItems at: 5) fName: (lineItems at: 2) lName: (lineItems at: 3).
            Arr addLast: temp.
        ].
        (jobType = 'salaried')
        ifTrue:[
            temp := Salaried new.
            temp setWeeklySalary: (lineItems at: 4) fName: (lineItems at: 2) lName: (lineItems at: 3).
            Arr addLast: temp.
        ].
        
        b := f nextLine.
    ].
1 to: (Arr size) do: [:i |
    ((Arr at: i) getEarning) displayNl
].