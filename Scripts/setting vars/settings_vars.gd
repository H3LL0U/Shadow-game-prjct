extends Node


		

#volume settings
var db_general = 70
var db_sfx = 50
var db_music = 50


var max_db_music = 20
var max_db_sfx = 20

var min_db_music = -60
var min_db_sfx = -30

#level settings
var max_lvl_reached = 0
var save_to = "user://variable.save"
func _ready():
	
	if FileAccess.file_exists(save_to):
		var file = FileAccess.open(save_to, FileAccess.READ)
		db_general = file.get_var(db_general)
		db_sfx = file.get_var(db_sfx)
		db_music = file.get_var(db_music)
		max_lvl_reached = file.get_var(max_lvl_reached)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		
		var file = FileAccess.open(save_to, FileAccess.WRITE)
		file.store_var(db_general)
		file.store_var(db_sfx)
		file.store_var(db_music)
		file.store_var(max_lvl_reached)
		
