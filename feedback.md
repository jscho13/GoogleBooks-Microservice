# EightLight Tic-Tac-Toe
### Feedback
- There's a bug where if the user hits enter on 1st move it defaults to `0`. This is because in Javascript `+` on an empty string is casted to `0`. Try using `parseInt()` instead.
- Please format your code by running it through a beautifier. It makes things much easier to read.
- Some of your `if-else` statements can be shortened to ternary operators. This makes it a lot easier to match the brackets in `if-else` clauses.
- Rename your variables so they reflect what they do. Generic names may have the correct description, but don't carry any meaning. For example:
  - `patterns_1` -> `first_move_options`
  - `patterns_2` -> `second_move_options`
  - `patterns_3` -> `valid_winning_combinations`

- On the topic of variables, it's considered poor form to use global scope because they can get polluted or have unintended side-effects that are difficult to trace back. Try passing around the state (e.g. `curr_turn` and `player`) as arguments instead.

### General Notes
Overall great job on this game, it's pretty neat that this computer will never lose. It runs fast because of the dictionary, and has a simple interface that's easy to use.
