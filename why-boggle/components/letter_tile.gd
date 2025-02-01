extends Button

class_name LetterTile

var letter:String
# Contains the x and y position of the button in the grid. Used to check adjacency.
var grid_x:int
var grid_y:int 

func set_letter(v):
	letter = v
	text = v
	
func set_grid_x(pos_x):
	grid_x = pos_x
	
func set_grid_y(pos_y):
	grid_y = pos_y





# Called when the node enters the scene tree for the first time.
func _ready():
	custom_minimum_size = Vector2(100, 100)
	set_default_tile_color()

func _on_pressed():
	EventBus.on_tile_pressed.emit(self)
	pass

func set_selected_tile_color() -> void:
	set_stylebox_color("normal", Color.RED)

func set_default_tile_color() -> void:
	set_stylebox_color("normal", Color.BLACK)

func set_stylebox_color(style_box_type: String, color: Color):
	
	var stylebox_theme: StyleBoxFlat = StyleBoxFlat.new()
	stylebox_theme.bg_color = color
	stylebox_theme.border_color = color
	
	add_theme_stylebox_override(style_box_type, stylebox_theme)
