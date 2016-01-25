class Board
	COLORS = %w(r g b y o p).freeze
	
	attr_reader :right_color, :right_spot
	
	def initialize
		@right_color  = 0
		@right_spot = 0
		@guess ||= ''
		@secret_code ||= ''
	end
	
	def generate_secret_code *args
		case args.size
			when 0 then @secret_code = COLORS.sample(4).join
			when 1 then @secret_code = args.first 
			else 
				puts "ERROR: Too many arguments."
		end
		puts "The secret code is #{@secret_code}."
	end

	def check_guess *args					# first arg is guess, [second is secret code]
		@right_color, @right_spot = 0, 0
		
		guess = args.first
		temp = guess.split("") 
		case args.size
			when 1 then secret_temp = @secret_code.clone
			when 2 then secret_temp = args.last
			else	
				puts "ERROR: Too many arguments." 
		end
		secret_temp.split("").map.with_index do |x, i|
			if temp[i] == secret_temp[i]
				temp[i] = 'x'
				secret_temp[i] = 'z'
				@right_spot += 1
			end
		end
		secret_temp.split("").map.with_index do |x, i|
			temp.map.with_index do |y, j|
				if temp[j] == secret_temp[i]
					temp[j] = 'x'
					@right_color += 1
					break
				end
			end
		end
		
		return guess == @secret_code
	end
	
	def	print_guess_results
		puts "Right color(s) in wrong place: #{@right_color}."
		puts "Right color(s) in the right place: #{@right_spot}."
	end

end