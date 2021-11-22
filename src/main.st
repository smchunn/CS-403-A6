Object subclass: Functions [
    checkOp: op threshold: aThreshold value: aValue[
        (op = 'eq')
        ifTrue:[
            ^ aValue = aThreshold
        ].
        (op = 'ne')
        ifTrue:[
            ^ aValue ~= aThreshold
        ].
        (op = 'ge')
        ifTrue:[
            ^ aValue >= aThreshold
        ].
        (op = 'le')
        ifTrue:[
            ^ aValue <= aThreshold
        ].
        (op = 'gt')
        ifTrue:[
            ^ aValue > aThreshold
        ].
        (op = 'lt')
        ifTrue:[
            ^ aValue < aThreshold
        ].
        ^ 1 = 0
    ]

    countEmployees: employees op: anOp threshold: aThreshold [
        | count |
        count := 0.
        1 to: (employees size) do: [:i |
            | amt |
            amt := (employees at: i) getEarning.
            (self checkOp: anOp threshold: aThreshold value: amt)
            ifTrue:[
                count := count + 1
            ]
        ].
        ^ count
    ]

    printEmployees: employees op: anOp threshold: aThreshold [
        1 to: (employees size) do: [:i |
            | amt |
            amt := (employees at: i) getEarning.
            (self checkOp: anOp threshold: aThreshold value: amt)
            ifTrue:[
                ((employees at: i) getInfo) displayNl.
                ('earned $') display.
                ((amt) roundTo: 0.01) displayNl. '' displayNl.
            ]
        ].
    ]
]
funcs := Functions new.

(((Smalltalk arguments size) ~= 2 ) and: [(Smalltalk arguments size) ~= 4])
ifTrue:[
    ('Usage: gst employee.st commission.st hourly.st salaried.st -f main.st empployee_file action') displayNl.
    ('or') displayNl.
    ('Usage: gst employee.st commission.st hourly.st salaried.st -f main.st empployee_file action operator threshold') displayNl.
    ('Valid actions: count print min max total avg') displayNl.
    ('Valid operators: eq ne gt ge lt le') displayNl.

    ObjectMemory quit: 0
].

f := FileStream open: (Smalltalk arguments at: 1) mode: #read ifFail:[
    'Unable to open ' display.
    (Smalltalk arguments at: 1) display.
    ' for reading'displayNl.
    ObjectMemory quit: 0
].
"b := f nextLine."
employeesAr := OrderedCollection new.
[f atEnd] whileFalse:
    [
        b := f nextLine.
        lineItems := b substrings.
        jobType := (lineItems at: 1).
        (jobType = 'commission')
        ifTrue:[
            temp := Commission new.
            temp setMinSal: (lineItems at: 4) Sales: (lineItems at: 5) commRate: (lineItems at: 6) fName: (lineItems at: 2) lName: (lineItems at: 3).
            employeesAr addLast: temp.
        ].
        (jobType = 'hourly')
        ifTrue:[
            temp := Hourly new.
            temp setHours: (lineItems at: 4) HourlyRate: (lineItems at: 5) fName: (lineItems at: 2) lName: (lineItems at: 3).
            employeesAr addLast: temp.
        ].
        (jobType = 'salaried')
        ifTrue:[
            temp := Salaried new.
            temp setWeeklySalary: (lineItems at: 4) fName: (lineItems at: 2) lName: (lineItems at: 3).
            employeesAr addLast: temp.
        ].
        
        "b := f nextLine."
    ].
(employeesAr size = 0)
ifTrue:[
    ('There are no employees.') displayNl
    ObjectMemory quit: 0.
].
action := Smalltalk arguments at: 2.
op := 'ge'.
threshold := 0.

(Smalltalk arguments size = 4)
ifTrue:[
    op := Smalltalk arguments at: 3.
    threshold := (Smalltalk arguments at: 4) asNumber.
].

count := funcs countEmployees: employeesAr op: op threshold: threshold.
(count = 0)
ifTrue:[
    ('There are no employees satisfied the specified condition.') displayNl.
    ObjectMemory quit: 3.
].
(action = 'count')
ifTrue:[
    'There are ' display.
    count display.
    ' employees' displayNl.
].
(action = 'print')
ifTrue:[
    funcs printEmployees: employeesAr op: op threshold: threshold.
].
(action = 'min')
ifTrue:[
    min := SmallInteger largest.
    1 to: (employeesAr size) do: [:i |
        amt := (employeesAr at: i) getEarning.
        (((funcs) checkOp: op threshold: threshold value: amt) and: [amt < min])
        ifTrue:[
            min := amt.
        ].
    ].
    funcs printEmployees: employeesAr op: 'eq' threshold: min.
].
(action = 'max')
ifTrue:[
    max := -1.
    1 to: (employeesAr size) do: [:i |
        amt := (employeesAr at: i) getEarning.
        (((funcs) checkOp: op threshold: threshold value: amt) and: [amt > max])
        ifTrue:[
            max := amt.
        ].
    ].
    funcs printEmployees: employeesAr op: 'eq' threshold: max.
].
((action = 'total') or: [action = 'avg'])
ifTrue:[
    total := 0.
    1 to: (employeesAr size) do: [:i |
        amt := (employeesAr at: i) getEarning.
        ((funcs) checkOp: op threshold: threshold value: amt)
        ifTrue:[
            total := total + amt.
        ].
    ].
    (action = 'total')
    ifTrue:[
        'Total payment is $' display.
        ((total) roundTo: 0.01) displayNl. '' displayNl.
    ]
    ifFalse:[
        'Average payment per employee is $' display.
        ((total / count) roundTo: 0.01) displayNl. '' displayNl.
    ].
].