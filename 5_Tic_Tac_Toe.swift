class Board 
{
    var size: Int
    var states = [[Character]]()

    init(size: Int) 
    {
        self.size = size
        for _ in 1...size 
        {
            var tmp = [Character]()
            for _ in 1...size 
            {
                tmp.append("_")
            }
            states.append(tmp)
        }
    }

    func draw()
    {
        for i in 0...size - 1 
        {
            if i == 0 
            {
                for _ in 1...2 * size + 3 
                {
                    print("#", terminator: "")
                }
                print("")
            }
            print("#", terminator: "")
            
            for state in states[i] 
            {
                print(" \(state)", terminator: "")
            }
            print(" #")   
        
            if i == size - 1 
            {
                for _ in 1...2 * size + 3 
                {
                    print("#", terminator: "")
                }
                print("")
            }
        }
    }

    func check_for_end() -> (Bool, Character?)
    {
        for (i, row) in states.enumerated()
        {
            var result = check_states(row)
            if result.0
            {
                return result
            }

            var column = [Character]()
            for j in 0...size - 1
            {
                column.append(states[j][i])
            }
            result = check_states(column)
            if result.0
            {
                return result
            }

            var left_diagonal = [Character]()
            for j in 0...size - 1
            {
                left_diagonal.append(states[j][j])
            }
            result = check_states(left_diagonal)
            if result.0
            {
                return result
            }

            var right_diagonal = [Character]()
            for j in 0...size - 1
            {
                right_diagonal.append(states[j][size - j - 1])
            }
            result = check_states(right_diagonal)
            if result.0
            {
                return result
            }
        }
        
        for row in states
        {
            if row.contains("_")
            {
                return (false, nil)
            }
        }

        return (true, nil)
    }

    func check_states(_ states: [Character]) -> (Bool, Character?)
    {
        if states == ["x", "x", "x"]
        {
            return (true, "x")
        }
        else if states == ["o", "o", "o"]
        {
            return (true, "o")
        }

        return (false, nil)
    }

    func get_possible_moves() -> [(Int, Int)]
    {
        var possible_moves = [(Int, Int)]()
        for i in 0...size - 1
        {
            for (j, state) in states[i].enumerated()
            {
                if state == "_"
                {
                    possible_moves.append((i, j))
                }
            }
        }

        return possible_moves
    }

    func copy() -> Board
    {
        let newBoard = Board(size: self.size)
        for i in 0...size - 1
        {
            for j in 0...size - 1
            {
                newBoard.states[i][j] = self.states[i][j]
            }
        }

        return newBoard
    }
}

class Player
{
    var board: Board
    var token: Character

    init(board: Board, token: Character) 
    {
        self.board = board
        self.token = token
    }

    func move()
    {
        print("Enter the position on which you want to make a move: ", terminator: "")
        let str_position = readLine()
        let separated_position = str_position!.split(separator: " ")
        make_move((Int(separated_position[0]) ?? 0, Int(separated_position[1]) ?? 0))
    }

    func make_move(_ position: (Int, Int))
    {
        board.states[position.0][position.1] = token
    }
}

enum DifficultyLevel: Int
{
    case EASY = 1
    case MEDIUM
    case HARD
}

class AIPlayer: Player
{
    var level: DifficultyLevel
    var mediumNextMove: DifficultyLevel
    
    init(board: Board, token: Character, level: DifficultyLevel)
    {
        self.level = level
        self.mediumNextMove = DifficultyLevel.EASY
        super.init(board: board, token: token)
    }

    override func move()
    {
        if level == DifficultyLevel.EASY
        {
            easy_move()
        }
        else if level == DifficultyLevel.MEDIUM
        {
            medium_move()
        }
        else if level == DifficultyLevel.HARD
        {
            hard_move()
        }
    }

    func easy_move()
    {
        let possible_moves = board.get_possible_moves()
        let random_move = possible_moves.randomElement()!
        make_move(random_move)
    }

    func medium_move()
    {
        if mediumNextMove == DifficultyLevel.EASY
        {
            easy_move()
            mediumNextMove = DifficultyLevel.HARD
        }
        else
        {
            hard_move()
            mediumNextMove = DifficultyLevel.EASY
        }
    }

    func hard_move()
    {
        let move = minimax(board, 3, true).1 ?? (0,0)
        make_move(move)
    }

    func minimax(_ board: Board, _ depth: Int, _ maximizingPlayer: Bool) -> (Int, (Int, Int)?)
    {
        let result = board.check_for_end()
        if result.0
        {
            if result.1 == token
            {
                return (Int.max, nil)
            }
            else if result.1 == nil
            {
                return (0, nil)
            }
            else
            {
                return (Int.min, nil)
            }
        }

        if depth == 0
        {
            return (heuristic_function(board), nil)
        }

        var best_score = (maximizingPlayer == true) ? Int.min : Int.max
        var best_move: (Int, Int)? = nil

        for move in board.get_possible_moves()
        {
            let new_board = board.copy()
            new_board.states[move.0][move.1] = (maximizingPlayer == true) ? "o" : "x"
            let score = minimax(new_board, depth-1, !maximizingPlayer).0

            if maximizingPlayer && score > best_score
            {
                best_score = score
                best_move = move
            }

            else if !maximizingPlayer && score < best_score
            {
                best_score = score
                best_move = move
            }
        }

        return (best_score, best_move)
    }

    func heuristic_function(_ board: Board) -> Int
    {
        var score = 0
        var opponent_token: Character
        if token == "x"
        {
            opponent_token = "o"
        }
        else
        {
            opponent_token = "x"
        }

        for row in board.states
        {
            score = self.calculate_score(row, score, opponent_token)
        }
        for i in 0...board.size - 1
        {
            var column = [Character]()
            for j in 0...board.size - 1
            {
                column.append(board.states[j][i])
            }
            score = calculate_score(column, score, opponent_token)
        }

        var diagonal1 = [Character]()
        var diagonal2 = [Character]()
        for i in 0...board.size - 1
        {
            diagonal1.append(board.states[i][i])
            diagonal2.append(board.states[i][board.size - i - 1])
        }

        score = calculate_score(diagonal1, score, opponent_token)
        score = calculate_score(diagonal2, score, opponent_token)

        return score
    }

    func calculate_score(_ row: [Character], _ score: Int, _ opponent_token: Character) -> Int
    {
        var score = score
        if (row.filter{$0 == token}.count == 3)
        {
            score += 100
        }
        else if (row.filter{$0 == self.token}.count == 2 && row.filter{$0 == "_"}.count == 1)
        {
            score += 10
        }
        else if (row.filter{$0 == self.token}.count == 1 && row.filter{$0 == "_"}.count == 2)
        {
            score += 1
        }
        else if (row.filter{$0 == opponent_token}.count == 3)
        {
            score -= 100
        }
        else if (row.filter{$0 == opponent_token}.count == 2 && row.filter{$0 == "_"}.count == 1)
        {
            score -= 10
        }
        else if (row.filter{$0 == opponent_token}.count == 1 && row.filter{$0 == "_"}.count == 2)
        {
            score -= 1
        }
    
        return score
    }
}

class Game
{
    var board: Board
    var player: Player
    var ai_player: AIPlayer
    var current_player: Player
    var winner: Character?

    init() 
    {
        board = Board(size: 3)
        player = Player(board: board, token: "x")
        ai_player = AIPlayer(board: board, token: "o", level: DifficultyLevel.EASY)
        current_player = player
        winner = nil
    }

    func start()
    {
        print("======= MAIN MENU =======")
        print("1. Start game")
        print("2. Quit")

        print("Enter a number: ", terminator: "")
        let choice = readLine()
        if choice == "1"
        {
            choose_difficulty_level()
            play()
        }
    }

    func choose_difficulty_level()
    {
        print("Enter a difficulty level [1 - EASY | 2 - MEDIUM | 3 - HARD]: ", terminator: "")
        let level = readLine()
        ai_player.level = DifficultyLevel(rawValue: Int(level!) ?? 1)!
    }

    func play()
    {
        while true
        {
            print("======= YOU: \(player.token) | AI Player: \(ai_player.token) =======")
            print((current_player === ai_player) ? "AI Player's move..." : "Your move...")
            board.draw()
            current_player.move()

            let result = board.check_for_end()
            if result.0
            {
                winner = result.1
                break
            }

            switch_player()
        }

        show_result()
    }

    func switch_player()
    {
        current_player = (current_player === player) ? ai_player : player
    }

    func show_result()
    {
        board.draw()
        if winner == nil
        {
            print("======= DRAW =======")
        }
        else
        {
            print("======= WINNER: \(winner!) =======")
        }

        print("Enter p to play again, q to quit: ", terminator: "")
        let choice = readLine()

        if choice == "p"
        {
            let newGame = Game()
            newGame.choose_difficulty_level()
            print("\n")
            newGame.play()
        }
    }
}

var game = Game()
game.start()
