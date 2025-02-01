extends Control

class_name BoggleGame

@onready var game_grid:GameGrid = %GameGrid
@onready var selected_letters_label:Label = %SelectedLetters

var tile_sequence:Array # Contains the letters currently selected
var word_list:Array # Contains all the valid words the user submitted

func _ready():
	
	# Prepare the grid
	game_grid.create_boggle_grid()
	EventBus.on_tile_pressed.connect(tile_pressed)
	
	# Prepare the database
	WordService.ready_database()

func reset_sequence():
	tile_sequence = []
	game_grid.reset_tiles()
	
# On letter tile press:
# Check if previous tile is me. If yes, change my color to default.
# Check if previous button adjacent to me
# If yes, change my color and save my letter to GAME SESSION
# If not, reset word sequence and return all buttons to default color

func tile_pressed(tile:LetterTile):
	
	var prev_tile:LetterTile
	
	if tile_sequence:
		prev_tile = tile_sequence[-1]
		if prev_tile == tile:	# Same tile pressed. Change tile color and remove from sequence
			print("Same tile pressed")
			tile.set_default_tile_color() 
			tile_sequence.pop_back()
		else:
			if tile in tile_sequence: # Check if tile is already pressed before
				# Tile already pressed
				reset_sequence()
			else:
				if game_grid.is_adjacent(tile, prev_tile):
					tile_sequence.append(tile)
					tile.set_selected_tile_color() 
				else:
					# Tile not adjacent
					reset_sequence()
	else:
		# Adding the first tile into the sequence
		tile_sequence.append(tile)
		tile.set_selected_tile_color() 
		
	var selected_letters:Array = tile_sequence.map(get_letter)
	selected_letters_label.text = get_sequence_as_word(selected_letters)

func add_to_sequence(letter:String) -> void:
	tile_sequence.append(letter)
		

func get_letter(tile:LetterTile) -> String:
	return tile.letter
	
func get_sequence_as_word(arr:Array) -> String:
	var word = ""
	
	for letter in arr:
		word += String(letter)
	
	return word



func add_to_word_list(word:String) -> void:
	word_list.append(word)


func _on_word_submit():
	# Get the current letter sequence
	var word:String = selected_letters_label.text
	
	if word.length() > 3:	# Words need to be at least three letters
		if not(word in word_list):
			if WordService.is_valid_word(word):
				print(word, " is a valid word.")
				add_to_word_list(word)
		
	print("Current word list: ", word_list)
	pass # Replace with function body.
