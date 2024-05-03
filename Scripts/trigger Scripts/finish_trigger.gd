extends Node2D

@export var activate_immediately = false
@onready var setting_vars = get_node("/root/SettingsVars")
@onready var current_lvl_name = get_tree().get_current_scene().get_name()
var chr_entred = false
var ref_to_chr = null

func find_current_lvl():
	var _index = current_lvl_name.rfind("_")
	var current_lvl = current_lvl_name.substr(_index + 1, current_lvl_name.length())
	return int(current_lvl)
func _on_area_2d_body_entered(body):
	if body.name == "Main character":
		ref_to_chr = body
		chr_entred = true
	
		
	


func _on_area_2d_body_exited(body):
	if body.name == "Main character":
		chr_entred = false
		ref_to_chr = body
		
func _process(delta):
	if (Input.is_action_just_pressed("use") and chr_entred) or (activate_immediately and chr_entred):
		if ref_to_chr != null:
			var current_lvl = find_current_lvl()
			if current_lvl > setting_vars.max_lvl_reached:
				setting_vars.max_lvl_reached = current_lvl
			ref_to_chr.win()
