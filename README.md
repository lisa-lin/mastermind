# Mastemind in Ruby (with AI)
This is a command-line based Mastermind game (with AI) written in Ruby where
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

The AI you will play against use a slightly different implementation of [Donald Knuth's five-guess algorithm](http://en.wikipedia.org/wiki/Mastermind_%28board_game%29#Five-guess_algorithm).
I've changed some steps to make the code less computationally expensive. Here is the algorithm: 
```
1. Create the set of 1296 possible codes. We have six colors that can be distributed in 4 positions, 
   so it's 6^4=1296 possible permutations.(allowing duplicates)
2. Start with these initial guesses: 'rrgg', 'bbyy' and 'oopp' to narrow down the color choices.
3. Play the guess to get a response.
4. In case the response is four right spots, you won the game. Otherwise continue to step 5
5. Remove from S any code that would not give the same result if it(the guess) would be the secret code.
6. Choose a random sample from the remaining codes of the set S.
7. Repeat from step 3.
```

As this game is an excercise in illustrating software engineering, OOP, and project organization rather than computer science, the code is not optimized for minimal number of guesses.