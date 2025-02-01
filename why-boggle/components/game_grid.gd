extends Node2D

class_name GameGrid
# This script contains the properties and functions for the game grid.

const HORIZONTAL_MAX:int = 4
const VERTICAL_MAX:int = 4

var tile_sequence:Array # Contains the letters currently selected
var previous_button:Button


func _ready():
	EventBus.on_tile_pressed.connect(tile_pressed)
	create_boggle_grid()

# Creates a new boggle grid with new letters
func create_boggle_grid():
	
	# Get 16 letters for the grid
	var letters = GameHelper.get_random_letters(HORIZONTAL_MAX * VERTICAL_MAX)
	
	# Create a 16 buttons and assign a letter from the randomised letters 
	var boggle_buttons:Array
	
	var x_coor = 0
	var y_coor = 0
	
	var letter_tile_prefab = preload("res://components/letter_tile.tscn")
	for letter in letters:
		var button:LetterTile = letter_tile_prefab.instantiate()
		
		var test =  str(letter,x_coor,y_coor)
		button.set_letter(letter)
		
		button.set_grid_x(x_coor)
		button.set_grid_y(y_coor)
		
		if x_coor < HORIZONTAL_MAX - 1:
			x_coor += 1
		else:
			x_coor = 0
			if y_coor < VERTICAL_MAX - 1:
				y_coor += 1
		
		$GridContainer.add_child(button)
		
	
	# Position the buttons into a grid
	
	pass


func add_to_sequence(letter:String) -> void:
	tile_sequence.append(letter)

func reset_sequence():
	tile_sequence = []
	
	
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
				print("Tile already pressed")
			else:
				if is_adjacent(tile, prev_tile):
					tile_sequence.append(tile)
					tile.set_selected_tile_color() 
				else:
					print("Tiles not adjacent")
	else:
		print("Adding first tile...")
		tile_sequence.append(tile)
		tile.set_selected_tile_color() 
		
	print(tile_sequence.map(get_letter_sequence))
		

func get_letter_sequence(tile:LetterTile) -> String:
	return tile.letter
	
func is_adjacent(curr_tile:LetterTile, prev_tile:LetterTile) -> bool:
	var adjacent:bool = false
	
	if curr_tile.grid_x <= prev_tile.grid_x + 1 and curr_tile.grid_x >= prev_tile.grid_x - 1:
		if curr_tile.grid_y <= prev_tile.grid_y + 1 and curr_tile.grid_y >= prev_tile.grid_y - 1:
			if curr_tile != prev_tile:
				adjacent = true

	return adjacent
