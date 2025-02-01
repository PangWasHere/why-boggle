extends Control

class_name GameGrid
# This script contains the properties and functions for the game grid.

const HORIZONTAL_MAX:int = 4
const VERTICAL_MAX:int = 4



func _ready():
	pass

## Creates a new boggle grid with new letters
func create_boggle_grid():
	
	# Get 16 letters for the grid
	var letters = WordService.get_random_letters(HORIZONTAL_MAX * VERTICAL_MAX)
	
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
		
		# Assign pseudo-coordinates to check adjacency. See is_adjacent() function below
		if x_coor < HORIZONTAL_MAX - 1:
			x_coor += 1
		else:
			x_coor = 0
			if y_coor < VERTICAL_MAX - 1:
				y_coor += 1
		
		$GridContainer.add_child(button)
	
func is_adjacent(curr_tile:LetterTile, prev_tile:LetterTile) -> bool:
	var adjacent:bool = false
	
	if curr_tile.grid_x <= prev_tile.grid_x + 1 and curr_tile.grid_x >= prev_tile.grid_x - 1:
		if curr_tile.grid_y <= prev_tile.grid_y + 1 and curr_tile.grid_y >= prev_tile.grid_y - 1:
			if curr_tile != prev_tile:
				adjacent = true

	return adjacent

func reset_tiles() -> void:
	var tiles = $GridContainer.get_children()
	
	for tile:LetterTile in tiles:
		tile.set_default_tile_color()
	
