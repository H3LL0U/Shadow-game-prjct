extends Button

var locked = true
@export var lvl_num = 1
@onready var settings_vars = get_node("/root/SettingsVars")
func _ready():
	if settings_vars.max_lvl_reached+1>=lvl_num and ResourceLoader.exists("res://objects/levels/level_"+str(lvl_num)+".tscn"):
		locked = false
	else:
		locked = true
	if not locked:
		$lock.visible = false
	$".".text = str(lvl_num)
	



func _on_pressed():
	if not locked:
		get_tree().change_scene_to_file("res://objects/levels/level_"+str(lvl_num)+".tscn")
