# Mastemind in Ruby (with AI)
Command-line Mastermind game (with AI) written in Ruby

This is a command-line based Mastermind game written in Ruby where
the player can either attempt to break a computer-generated code or
create a code that the computer breaks. 

####RULES
The codemaker makes a code by choosing four colors (out of 
six possible colors) in their chosen order. The codebreaker has 12
turns to attempt to guess the correct colors in the correct order.
Colors can be used any number of times (e.g. green-green-green-green
is a possibility). Each turn, the codebreaker is given feedback on
their guess. Either the correct color and in the correct
position or the correct color but in the wrong position. 
It is up to the codebreaker to solve the code in as few turns as possible.

To run the game, enter `ruby mastermind.rb` at your command-line.

AI Algorithm Explanation
------------------------

The AI algorithm is similar to the one developed by Donald Knuth which solves the game in approximately 4.340 turns, however, unlike Knuth's algorithm, it does not rank subsequent guesses to maximize its chance of getting the code right.  Instead it just selects from the remaining possible codes randomly.  

It takes the following steps:

1. Guess a code in 'aaaa' format. Code is selected randomly.
2. Remove from the set of possibilities any code that yields the same feedback as the last guess.
3. Make a random guess from the remaining set.
4. Repeat until it wins.

As this game is an excercise in illustrating software engineering, OOP, and project organization rather than computer science, the code is not optimized for minimal number of guesses.

See [Mastermind Algorithm] (http://en.wikipedia.org/wiki/Mastermind_%28board_game%29#Five-guess_algorithm) on Wikipedia for more info.  