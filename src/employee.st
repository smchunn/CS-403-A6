Object subclass: Employee [
	| firstName lastName |
	Employee class >> new [
		<category: 'instance creation'>
		| r |
		r := super new.
		r init.
		^r
	]
	
	init [
		<category: 'initialization'>
		firstName := 'first'.
		lastName := 'last'	
	]
	
	setFirstName: first [
		firstName := first
	]
	setLastName: last [
		lastName := last
	]
	getFirstName[
		^firstName
	]
	getLastName[
		^lastName
	]
	getInfo [
		^ (firstName, ' ', lastName)
	]
]

