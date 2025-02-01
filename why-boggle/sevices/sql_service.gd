extends RefCounted

class_name SQLService

const PATH_TO_DB:String = "res://data/eng-words-dict.db"
var db : SQLite


func open_database() -> void:
	db = SQLite.new()
	db.path = PATH_TO_DB
	db.open_db()
	
func close_database() -> void:
	db.close_db()


func is_valid_word(word:String) -> bool:
	var is_valid = false
	
	var condition:String = "word = '" + word.capitalize() + "'"
	
	var result = db.select_rows("entries", condition, ["word"])
	if result:
		is_valid = true
	
	return is_valid
