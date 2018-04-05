# Scrabble Rails Livecode implementation

## Project Outline

1. Models
    1. `TileBag`
        1. `tiles` (String)
        1. `shake!` method (shuffles tiles)
    1. `Player`
        1. `has_many :turns`
        1. `name` (String)
        1. `tile_rack` (String)
        1. `draw_tiles!` method (takes TileBag, removes N tiles and adds to Tile Rack)
        1. `play!` method (takes word, removes each letter in word from Tile Rack, creates new Turn model then calls draw_tiles!, raises error if insufficient tiles)
    1. `Turn`
        1. `belongs_to :player`
        1. `word` (String)
        1. `score` (Integer, calculated from word)
1. Routes
    1. `/` - GET for Home page
    1. `/players`
        1. CRUD routes
        1. `play` (member route) - POST for playing a new word
    1. `/reset` - DELETE for resetting the whole game (remove all players, turns, and reset tile bag)
1. Views
    1. Home page
        1. Shows the history of Turns in reverse chronological order
        1. Shows which Player has won (if any)
        1. Link to each Player’s show page
        1. Buttons to add/edit/remove Player
        1. Button to reset game
    1. Player
        1. Index -- redundant since this is also on home page
            1. List of existing Players
            1. Buttons to add/edit/remove Player
        1. Show
            1. Displays: name, history of Turns, total score
            1. Displays current Tile Rack
            1. Form to play new word
            1. Buttons to edit/remove Player
        1. New
            1. Form for creating new Player
            1. Includes name input text field
        1. Edit
            1. Form for updating existing Player
            1. Includes name input text field
