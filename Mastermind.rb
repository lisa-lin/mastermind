require_relative 'Board'
require_relative 'Computer'

class Mastermind
	MAX_GUESS = 12

	def initialize
		@board = Board.new
	end
	
	def start
		puts "Welcome to MASTERMIND!"
		print "Do you want to be a code(b)reaker or a code(m)aker? "
		is_maker = (gets.chomp.downcase == "m") 
		
		computer = Computer.new @board if is_maker
		
		if is_maker
			print "What shall the secret code be? "
		  @board.generate_secret_code gets.chomp.downcase.gsub(/\s+/, "")
		else
			@board.generate_secret_code
			puts "Secret code has been generated."
		end
		
		remaining_guesses = MAX_GUESS
		until remaining_guesses == 0 do 
			puts "You have #{remaining_guesses} guesses remaining."
			
			if is_maker
				@guess = computer.guess(remaining_guesses)
				puts "The computer's guess is #{@guess}."
			else
				print "Enter your guess: "
				@guess = gets.chomp
			end
			
			remaining_guesses -= 1
			break if @board.check_guess @guess
			@board.print_guess_results
			computer.filter_combos(@board.right_color, @board.right_spot) if is_maker
			puts if remaining_guesses > 0
		end
		puts
		puts remaining_guesses == 0 ? "YOU LOSE!" : "YOU WIN!"
	end
end

game = Mastermind.new
game.start
