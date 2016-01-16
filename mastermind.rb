class Game
	attr_reader :game
	
	def initialize
		@game = game
	end
	
	def start
		puts "Welcome to MASTERMIND!"
		puts "Do you want to (P)lay or (Q)uit?"	
		check_answer
	end
	
	def check_answer
		ans = gets.chomp.downcase
		ans == "p" ? play : quit
	end
	
	def play
		p = Player.new("Lisa")
		p.hello
		board = Board.new
		board.start
	end
	
	def quit
		puts "Better choose 'p' next time..."
	end
	
end

class Player
	attr_reader :name
		
	def initialize name
		@name = name
	end
	
	def hello
		puts "Hello #{@name}!"
	end
end

class Board
	COLORS = %w(r g b y o p).freeze
	
	attr_reader :guess, :count_guess, :total_guesses, :secret_code
	
	def initialize
		@guess ||= "xxxx"
		@secret_code ||= "zzzz"
		@count_guess = 0
		@total_guesses = 12
		@right_color = 0			# right color only
		@right_spot = 0				# right color and spot
		@possible_combos = COLORS.repeated_permutation(4).to_a			# creates 1296 possible combos		
	end
	
	def start
		puts "Do you want to be a code(b)reaker or a code(m)aker?"
		ans = gets.chomp.downcase
		ans == "m" ? codemaker : codebreaker
	end
	
	def codebreaker
		@secret_code = COLORS.sample(4).join
		puts "Secret code has been generated."
		puts @secret_code
		unless guessed(secret_code)
			12.times do 
				puts "What is your guess?"
				@guess = gets.chomp
				puts "Your guess is #{@guess}."
				check_guess(@guess, @secret_code)
			end
		end
	end
	
	def codemaker
		puts "What shall the secret code be?"
		@secret_code = gets.chomp
		#summon_cpu
		cpu_guesses
	end
	
	def cpu_guesses
		unless guessed(secret_code)
			12.times do 
				puts "What is your guess?"
				@guess = cpu_best_guess
				puts "The CPU's guess is #{@guess}."
				check_guess(@guess, @secret_code)
				filter_combos(@guess, @possible_combos, @right_color, @right_spot)
				#puts @possible_combos
			end
		end
	end
	
	def cpu_best_guess
		return "rrgg" if @total_guesses - @count_guess == 12
		return "bbyy" if @total_guesses - @count_guess == 11
		return "oopp" if @total_guesses - @count_guess == 10
		
		cpu_guess = @possible_combos.sample(1).join	
		return cpu_guess
	end
	
	def filter_combos(last_guess, permutations, right_color, right_spot)
		@last_guess_rc = right_color
		@last_guess_rs = right_spot
		lg_array = last_guess.clone.split("")
		# Loop through all the permutations and compare it with the last guess
		# Notes: right_color and right_spot need to be stored into an instance variable (to filter_combos method)
		# Do each loop through all permutations
		# For each permutation, call position(permutation, last_guess)
		
		@possible_combos.each do |permutation|
			positions(permutation.join, last_guess)
			
			# If last guess' right color and spot both equal 0, loop through lg_array 
			# Delete combos with lg_array's colors from the set of possible combos

			if @last_guess_rc + @last_guess_rs == 0
				lg_array.each do |color|
					@possible_combos.delete_if {|permutation| permutation.include?(color)}
				end
			end

			# If results of the permutation compared to last guess differ, then delete permutation from array
			if ((@last_guess_rc != @right_color) && (@last_guess_rs != @right_spot))
				@possible_combos.delete(permutation)
			end
		end	
		puts @possible_combos.length
	end
	
	
	def summon_cpu
		cpu = PlayerAI.new(@secret_code)
		cpu.start
	end
	
	def check_guess(current_guess, current_secret_code)
		@count_guess += 1
		guessed(current_secret_code)
		positions(current_guess, current_secret_code)
		puts "Right color(s) in wrong place: #{@right_color}"
		puts "Right color(s) in the right place: #{@right_spot}"
	end
	
	def guessed(secret_code)
		@guess == secret_code ? win : remaining_guesses
	end
	
	def win
		puts "You win!"
		exit
	end
	
	def remaining_guesses
		#puts @total_guesses
		#puts @count_guess
		rem_guesses = @total_guesses - @count_guess
		puts "#{rem_guesses} guesses remaining..."
		if rem_guesses == 0
			puts "No more guesses! The secret code was #{@secret_code}."
			exit
		end
	end
	
	def positions(permutation, last_guess) 	 
		@right_color = 0
		@right_spot = 0
		
		temp = permutation.split("") 
		secret_temp = last_guess.clone
		
		secret_temp.split("").map.with_index do |x, i|
			if temp[i] == secret_temp[i]
				temp[i] = 'x'
				secret_temp[i] = 'z'
				@right_spot += 1
			end
		end
		
		secret_temp.split("").map.with_index do |x, i|
			temp.map.with_index do |y, j|
				#puts "i: #{i} & j: #{j} & temp[j]: #{temp[j]} & last_guess[i]: #{last_guess[i]} & right spot: #{@right_spot} & right color: #{@right_color}"
				if temp[j] == secret_temp[i]
					temp[j] = 'x'
					@right_color += 1
					break
				end
			end
		end
	end

end
	

###GAME STARTER###
game = Game.new
game.start