extends Node2D


var settings_vars



func _ready():
	settings_vars = get_node("/root/SettingsVars")
	$"Control/VBoxContainer/general sounds slider".value = settings_vars.db_general
	$"Control/VBoxContainer/SFX slider".value = settings_vars.db_sfx
	$"Control/VBoxContainer/music slider".value = settings_vars.db_music
	#$Control/VBoxContainer/HBoxContainer/resume.grab_focus()

func _on_general_sounds_slider_value_changed(value):
	settings_vars.db_general = $"Control/VBoxContainer/general sounds slider".value
	



func _on_sfx_slider_value_changed(value):
	settings_vars.db_sfx = $"Control/VBoxContainer/SFX slider".value



func _on_music_slider_value_changed(value):
	settings_vars.db_music =$"Control/VBoxContainer/music slider".value




func _on_quit_pressed():
	get_tree().change_scene_to_file("res://objects/levels/main_menu.tscn")
	
	


func _on_resume_pressed():
	visible = false
	
