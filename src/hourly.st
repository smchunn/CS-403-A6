Employee subclass: Hourly [
    | Hours HourlyRate |
    init [
        Hours := 0.
        HourlyRate := 0.
        ^ super init
    ]

    setHours: numHours HourlyRate: aHourlyRate fName: aFName lName: aLName [
        Hours := numHours asNumber.
        HourlyRate := aHourlyRate asNumber.
        self setFirstName: aFName.
        self setLastName: aLName
    ]

    getEarning [
        | earning |
        (Hours > 50)
        ifTrue:[
            earning := ((40 * HourlyRate) + (10 * HourlyRate * 1.5) + ((Hours - 50) * HourlyRate * 2))
        ]
        ifFalse:[
            (Hours > 40)
            ifTrue:[
                earning := ((40 * HourlyRate) + ((Hours - 40) * HourlyRate * 1.5))
            ]
            ifFalse:[
                earning := (Hours * HourlyRate)
            ].
        ].
        ^earning.
    ]
]