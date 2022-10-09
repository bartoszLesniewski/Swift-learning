import Foundation

class Game 
{
    var word: String
    var hiddenWord: String
    var numberOfTries: Int
    var categories = Dictionary<String, [String]>()
    var level: DifficultyLevel
    var category: String

    init()
    {
        word = ""
        hiddenWord = ""
        numberOfTries = 0
        level = DifficultyLevel.EASY
        category = "cities"
        categories = ["countries": ["POLAND", "NORWAY", "GERMANY", "DENMARK"],
                      "animals": ["SNAKE", "DONKEY", "BUTTERFLY", "CATERPILLAR"],
                      "sports": ["BASKETBALL", "TENNIS", "SWIMMING", "SNOWBOARDING"]]
    }

    func play()
    {
        menu()
    }

    func menu()
    {
        print("\n-------WORD GAME-------\n")
        chooseCategory()
        chooseDifficultyLevel() 
        randWord()
        setNumberOfTries()

        gameplay()
    }

    func chooseCategory()
    {
        print("Choose category [1 - Countries | 2 - Animals | 3 - Sports]: ", terminator: "")
        let choice = readLine()

        if choice == "1"
        {
            category = "countries"
        }
        else if choice == "2"
        {
            category = "animals"
        }
        else if choice == "3"
        {
            category = "sports"
        }
    }

    func chooseDifficultyLevel()
    {
        print("Enter a difficulty level [1 - EASY | 2 - MEDIUM | 3 - HARD]: ", terminator: "")
        let choice = readLine()
        level = DifficultyLevel(rawValue: Int(choice!) ?? 1)!
    }

    func setNumberOfTries()
    {
        if level == DifficultyLevel.EASY
        {
            numberOfTries = word.count * 4
        }
        else if level == DifficultyLevel.MEDIUM
        {
            numberOfTries = word.count * 2
        }
        else
        {
            numberOfTries = word.count + 3
        }
    }

    func randWord()
    {
        word = categories[category]!.randomElement()!
        for _ in 1...word.count
        {
            hiddenWord += "_"
        }
    }

    func gameplay()
    {
        while (numberOfTries > 0 && word != hiddenWord)
        {
            print("\nTries left: \(numberOfTries)\n")
            displayHiddenWord()
            let letter = readLine()
            check(letter!.uppercased())
         
            numberOfTries -= 1
        }

        if word == hiddenWord
        {
            print("\nYou won! :)")
        }
        else
        {
            print("\nYou lost! :( The word was: \(word)")
        }
        
        print("Enter p to play again, q to quit: ", terminator: "")
        let choice = readLine()

        if choice == "p"
        {
            let newGame = Game()
            newGame.menu()
        }
    }

    func displayHiddenWord() 
    {
        for character in hiddenWord
        {
            print("\(character)   ", terminator:"")
        }
        print()
    }

    func check(_ letter: String)
    {
        var newHiddenWord = ""
        
        for i in 0...word.count - 1
        {
            let index = word.index(word.startIndex, offsetBy: i)

            if String(word[index]) == letter && String(hiddenWord[index]) == "_"
            {
                newHiddenWord += letter
            }
            else
            {
                newHiddenWord += String(hiddenWord[index])
            }
        }

        hiddenWord = newHiddenWord
    }
}

enum DifficultyLevel: Int
{
    case EASY = 1
    case MEDIUM
    case HARD
}

var game = Game()
game.play()
