extends Node2D

func _process(_delta):
	$"Main character/fade effect/Label".modulate = $"Main character/fade effect/Sprite2D".modulate 
	


func _on_area_2d_body_entered(body):
	if body.name == "Main character":
		$"Main character/fade effect/Label".visible = true


func _on_area_2d_2_body_entered(body):
	if body.name == "Main character":
		get_tree().change_scene_to_file("res://objects/levels/main_menu.tscn")
