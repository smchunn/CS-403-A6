Employee subclass: Commission [
    | MinimumSalary Sales CommissionRate |
    
    init [
        MinimumSalary := 0.
        Sales := 0.
        CommissionRate := 0.
        ^ super init
    ]

    setMinSal: aMinSalary Sales: numSales commRate: aCommRate fName: aFName lName: aLName[
        MinimumSalary := aMinSalary asNumber.
        Sales := numSales asNumber.
        CommissionRate := aCommRate asNumber.
        self setFirstName: aFName.
        self setLastName: aLName
    ]

    getEarning [
        | earning |
        ((Sales * CommissionRate) > MinimumSalary)
        ifTrue:[
            earning := Sales * CommissionRate
        ]
        ifFalse:[
            earning := MinimumSalary
        ].
        ^ earning
    ]
]