Employee subclass: Salaried [
    | WeeklySalary |
    init [
        WeeklySalary := 0.
        ^ super init
    ]
    setWeeklySalary: aWeeklySalary fName: aFName lName: aLName [
        WeeklySalary := aWeeklySalary asNumber.
        self setFirstName: aFName.
        self setLastName: aLName
    ]
    getEarning [
        ^ WeeklySalary
    ]
]