extends Node

var sql_servicer:SQLService

# Called when the node enters the scene tree for the first time.
# Frequencies are in percentages and approximate the letter distribution in English.
const LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
const FREQUENCIES = [
	6.3,  # A
	2.1,  # B
	2.1,  # C
	3.1,  # D
	11.5, # E
	2.1,  # F
	2.1,  # G
	5.2,  # H
	5.2,  # I
	1.0,  # J
	1.0,  # K
	4.2,  # L
	2.1,  # M
	6.3,  # N
	7.3,  # O
	2.1,  # P
	1.0,  # Q
	5.2,  # R
	6.3,  # S
	9.4,  # T
	3.1,  # U
	2.1,  # V
	3.1,  # W
	1.0,  # X
	3.1,  # Y
	1.0   # Z
]


# Gets random n letters based on their assigned frequencies
func get_random_letters(num_letters:int) -> Array:
	var random_letters:Array
	
	# Calculate the total sum of the frequencies.
	var total_weight = 0.0
	for freq in FREQUENCIES:
		total_weight += freq

	var result = ""
	# Loop n times to pick n letters
	for i in range(num_letters):
		# Generate a random number between 0 and total_weight
		var r = randf() * total_weight
		var cumulative = 0.0
		# Iterate through the letters and frequencies to select the letter
		for j in range(LETTERS.length()):
			cumulative += FREQUENCIES[j]
			if r <= cumulative:
				if LETTERS[j] == 'Q':
					random_letters.append('Qu')
				else:
					random_letters.append(LETTERS[j])
				break
	
	return random_letters

func ready_database() -> void:
	sql_servicer = SQLService.new()
	sql_servicer.open_database()
	pass
	
func is_valid_word(word:String) -> bool:
	return sql_servicer.is_valid_word(word)
	
func close_database() -> void:
	sql_servicer.close_database()
