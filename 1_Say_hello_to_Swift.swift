import Foundation

// Strings and Text

// 1
var number1 = 5
var number2 = 10

print("\(number1) + \(number2) = \(number1 + number2)")

// 2
var str = "Gdansk University of Technology"
var newStr = ""

for character in str {
    if character == "n" {
        newStr += String("⭐️")
    }
    else {
        newStr += String(character)
    }
}

print(newStr)

// 3
var firstName = "Bartosz"
var lastName = "Lesniewski"

var firstNameReversed = String(firstName.reversed())
var lastNameReversed = String(lastName.reversed())
var reversed = "\(firstNameReversed) \(lastNameReversed)"
print(reversed)

// Control Flow

// 1
for _ in 1...11 {
    print("I will pass this course with best mark, because Swift is great!")
}

// 2
var N = 5
for i in 1...N {
    print(i * i)
}

// 3
N = 4
for _ in 1...N {
  for _ in 1...N {
    print("@", terminator: "")
  }
  print("")
}

// Arrays

// 1
var numbers = [5, 10, 20, 15, 80, 13]
var maxValue = numbers[0]

for number in numbers {
    if number > maxValue {
        maxValue = number
    }
}

print(maxValue)

// 2
for number in numbers.reversed() {
    print("\(number), ", terminator: "")
}
print()

// 3
var allNumbers = [10, 20, 10, 11, 13, 20, 10, 30]
var unique = [Int]()

for number in allNumbers {
    if !unique.contains(number) {
        unique.append(number)
    }
}

print(unique)

// Sets

// 1
var number = 10
var divisors = Set<Int>()

for i in 1...number {
    if number % i == 0 {
        divisors.insert(i)
    }
}

print(divisors.sorted())

// Dictionaries

// 1
var flights: [[String: String]] = [
    [
        "flightNumber" : "AA8025",
        "destination" : "Copenhagen"
    ],
    [
        "flightNumber" : "BA1442",
        "destination" : "New York"
    ],
    [
        "flightNumber" : "BD6741",
        "destination" : "Barcelona"
    ]
]

var flightNumbers = [String]()

for flight in flights {
    for (flightKey, flightValue) in flight {
        if flightKey == "flightNumber" {
            flightNumbers.append(flightValue)
        }
    }
}

print(flightNumbers)

// 2
var names = ["Hommer","Lisa","Bart"]
let LastName = "Simpson"
var fullName = [[String:String]]()

for fname in names {
    fullName.append(["fristName": fname, "lastName": LastName])
}

print(fullName)
