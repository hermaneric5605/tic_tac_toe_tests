class Board 
    attr_reader :board, :place

    def initialize
        @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        puts "Welcome to Tic Tac Toe.  Please select a number to the corresponding box"
        show_board
    end

    def show_board
        puts '-'*9          
        @board.each_slice(3) { |x| 
            puts x.join(' | ') 
            puts '-'*9
          }
      end

    def get_place
        @place = gets.to_i - 1
    end

    def free_space?
        @board[place].is_a? Integer
    end

    def put_marker(mark)
        get_place
        until free_space?
            puts "Invalid move, choose again!"
            get_place
        end
        @board[place] = mark
        show_board
    end

    def player1_win_condition
        ary = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
        ary.any? do |array| 
            array.all? { |num| @board[num - 1] == "X" }
        end
    end

    def player2_win_condition
        ary = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
        ary.any? do |array| 
            array.all? { |num| @board[num - 1] == "O" } 
        end
    end

    def draw_condition
        @board.all? { |num| num.is_a? String }
    end

    def end_game
        if player1_win_condition == true
            puts "Player 1 ('X') wins!"
            exit
        elsif player2_win_condition == true
            puts "Player 2 ('O') wins!" 
            exit
        elsif draw_condition == true && player1_win_condition == false && player2_win_condition == false
            puts "It's a draw!"
            exit
        end
    end
end

class Player
    attr_accessor :mark

    def initialize(mark)
        @mark = mark
    end
end

player_1 = Player.new("X")
player_2 = Player.new("O")
new_board = Board.new


until new_board.end_game
    puts "Player 1 ('X') turn"
    new_board.put_marker(player_1.mark)
    if new_board.end_game != true
        puts "Player 2 ('O') turn"
        new_board.put_marker(player_2.mark)
    end
end



