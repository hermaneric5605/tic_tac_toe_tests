class Board 
	attr_reader :board

	def initialize(player1, player2)
        @board = (1..9).to_a    
        @player_1 = player1
        @player_2 = player2
        puts "Player 1 is %s, Player 2 is %s." % [player1.mark, player2.mark]
        show_board
    end

    def play
      sequence = [@player_1,@player_2]
      until draw?
          puts "Player %s turn" % sequence.first.name
          put_marker(sequence.first.mark)
          if win?(sequence.first)
            puts "Player %s wins!" % sequence.first.name
            show_board  
            return 
          end
          sequence.rotate! 
        end
        puts "It's a draw!"
    end

     def show_board
        puts '-'*9          
        @board.each_slice(3) { |x| 
            puts x.join(' | ') 
            puts '-'*9
          }
    end

    def get_place
      while
          place = gets.to_i - 1 
          if ! place.between?(0,9)
              puts "Invalid move, use 1..9. Please choose again!"
              next
          end
          if ! free_space?(place) 
              puts "Invalid move, Pos. %i is occupied. Please choose again!"
              next
            end
            break 
        end
      return place
    end

    def free_space?(place)
        @board[place].is_a? Integer
    end

    def put_marker(mark)
        @board[get_place] = mark
        show_board
    end

    def win?(player)
      ary = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      ary.any? do |array| 
          array.all? { |num| @board[num - 1] == player.mark }
      end
    end

    def draw?
        @board.all? { |num| num.is_a? String }
    end

end

class Player
    attr_accessor :mark
    attr_accessor :name

    def initialize(name, mark)
        @name = name
        @mark = mark
    end
end

new_board = Board.new(Player.new('Fred', "X"), Player.new('Joe', "O"))
new_board.play
