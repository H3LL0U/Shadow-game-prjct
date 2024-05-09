extends Node2D

@onready var current_lvl_name = get_tree().get_current_scene().get_name()
@onready var setting_vars = get_node("/root/SettingsVars")


func find_current_lvl():
	var _index = current_lvl_name.rfind("_")
	var current_lvl = current_lvl_name.substr(_index + 1, current_lvl_name.length())
	return int(current_lvl)

func _on_visibility_changed():
	$AnimationPlayer.play("fall down")


func _on_retry_pressed():
	get_tree().reload_current_scene()



func _on_quit_pressed():
	get_tree().change_scene_to_file("res://objects/levels/main_menu.tscn")




func _on_next_level_pressed():
	
	var next_lvl = find_current_lvl()+1
	
	#if FileAccess.file_exists("res://objects/levels/level_"+str(next_lvl)+".tscn"):
	get_tree().change_scene_to_file("res://objects/levels/level_"+str(next_lvl)+".tscn")
	
	
