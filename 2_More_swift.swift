import Foundation

// Functions

// 1
func minValue (x: Int, y: Int) -> Int {
  if (x < y) {
    return x
  }
   
  return y;
}

print("minValue(x: 100, y: 50) = \(minValue(x: 100, y: 50))")
print("minValue(x: 24, y: 28) = \(minValue(x: 24, y: 28))")
print("minValue(x: 252, y: -723) = \(minValue(x: 252, y: -723))")
print("minValue(x: -34, y: 17) = \(minValue(x: -34, y: 17))")

// 2
func lastDigit(_ n: Int) -> Int {
    return n % 10
}

print("lastDigit(123) = \(lastDigit(123))")
print("lastDigit(45678) = \(lastDigit(45678))")
print("lastDigit(91011112) = \(lastDigit(9101112))")
print("lastDigit(13141516) = \(lastDigit(13141516))")

// 3
func divides(_ a: Int, _ b: Int) -> Bool {
    if (a % b == 0) {
        return true
    }
    
    return false
}

func countDivisors(_ n: Int) -> Int {
    var counter = 0
    for i in 1...n {
        if (divides(n, i) == true) {
            counter += 1
        }
    }
    
    return counter
}

func isPrime(_ n: Int) -> Bool {
    if (countDivisors(n) == 2) {
        return true
    }
    
    return false
}

print("divides(7, 3) = \(divides(7, 3))")
print("divides(8, 4) = \(divides(8, 4))")

print("countDivisors(1) = \(countDivisors(1))")
print("countDivisors(10) = \(countDivisors(10))")
print("countDivisors(12) = \(countDivisors(12))")

print("isPrime(3) = \(isPrime(3))")
print("isPrime(8) = \(isPrime(8))")
print("isPrime(13) = \(isPrime(13))")


// Closures

// 1
func smartBart(_ n: Int, closure: ()->()) -> () {
    for _ in 1...n {
        closure()
    }
}

smartBart(4, closure: { 
    print("I will pass this course with best mark, because Swift is great!")
})

// 2
let numbers = [10, 16, 18, 30, 38, 40, 44, 50]
let array = numbers.filter{$0 % 4 == 0}
print(array)

// 3
let largest = numbers.reduce(Int.min){max($0, $1)}
print(largest)

// 4
var strings = ["Gdansk", "University", "of", "Technology"]
let text = strings.reduce(""){$0 + $1 + " "}
print(text)

// 5
let numbers5 = [1, 2 ,3 ,4, 5, 6]
let result = numbers5.filter{$0 % 2 != 0}.map{$0 * $0}.reduce(0){$0 + $1}
print(result)


// Tuples

// 1
func minmax(_ a: Int, _ b: Int) -> (Int, Int) {
    let minValue = min(a, b)
    let maxValue = max(a, b)
    
    return (minValue, maxValue)
}

print("minmax(3, 10) = \(minmax(3, 10))")
print("minmax(50, 20) = \(minmax(50, 20))")
print("minmax(123, -450) = \(minmax(123, -450))")
print("minmax(654, 321) = \(minmax(654, 321))")

// 2
var stringsArray = ["gdansk", "university", "gdansk", "university", "university", "of", "technology", "technology", "gdansk", "gdansk"]
var countedStrings = [(String, Int)]()

for string in stringsArray {
    if (countedStrings.filter{$0.0 == string}.count == 0) {
        countedStrings.append((string, stringsArray.filter{$0 == string}.count))
    }
}

print(countedStrings)

// Enums

// 1
enum Day: Int {
    case Monday = 1
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
    
    func showEmoji() -> String {
        switch self {
            case .Monday:
                return "😖"
            case .Tuesday:
                return "😛"
            case .Wednesday:
                return "🧐"
            case .Thursday:
                return "🙃"
            case .Friday:
                return "😎"
            case .Saturday:
                return "💪"
            case .Sunday:
                return "😴"
        }
    }
}

let day = Day.Saturday
print(day.showEmoji())
print("Day number: \(day.rawValue)")
