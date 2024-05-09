extends Node2D
var _change_scene = false
func _ready():
	$music_player.load_song("Victory")
func _process(_delta):
	$"Main character/fade effect/Label".modulate = $"Main character/fade effect/Sprite2D".modulate 
	if _change_scene:
		get_tree().change_scene_to_file("res://objects/levels/main_menu.tscn")


func _on_area_2d_body_entered(body):
	if body.name == "Main character":
		$"Main character/fade effect/Label".visible = true


func _on_area_2d_2_body_entered(body):
	if body.name == "Main character":
		_change_scene = true
		
