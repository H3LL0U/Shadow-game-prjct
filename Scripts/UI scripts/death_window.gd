extends Node2D


func _on_reset_pressed():
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://objects/levels/main_menu.tscn")
