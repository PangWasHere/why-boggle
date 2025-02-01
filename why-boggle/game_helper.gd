extends Node

class_name GameHelper



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

static func get_random_letters(num_letters:int) -> Array:
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
