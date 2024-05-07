extends Control

@onready var settings_vars = get_node("/root/SettingsVars")
# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Play.grab_focus()


func _on_button_pressed():
	if ResourceLoader.exists("res://objects/levels/level_"+str(settings_vars.max_lvl_reached+1)+".tscn"):
		get_tree().change_scene_to_file("res://objects/levels/level_"+str(settings_vars.max_lvl_reached+1)+".tscn")
	else:
		get_tree().change_scene_to_file("res://objects/levels/level_"+str(settings_vars.max_lvl_reached)+".tscn")

func _on_quit_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_settings_pressed():
	$"../settings".visible = true


func _on_levels_pressed():
	$"../levels_menu".visible = true
