class Computer
	def initialize board
		@board = board
		@possible_combos = Board::COLORS.repeated_permutation(4).to_a
		@guess = "rrgg"
	end
	
	def guess(remaining_guesses)
		case remaining_guesses
			when 12 then @guess = "rrgg"
			when 11 then @guess = "bbyy"
			when 10 then @guess = "oopp"
			else
				@guess = @possible_combos.sample(1).join
		end
		return @guess
	end
	
	def filter_combos(right_color, right_spot)
		last_guess_rc = right_color
		last_guess_rs = right_spot
		temp = @guess.clone.split("")				# splits cpu's previous guess into an array
		
		@possible_combos.each do |permutation|
			@board.check_guess(permutation.join, temp.join)

			if last_guess_rc + last_guess_rs == 0
				temp.each do |color|
					@possible_combos.delete_if {|permutation| permutation.include?(color)}
				end
			end

			if ((last_guess_rc != @board.right_color) && (last_guess_rs != @board.right_spot))
				@possible_combos.delete(permutation)
			end
		end	
		puts "#{@possible_combos.length} possible combinations left."
	end
end