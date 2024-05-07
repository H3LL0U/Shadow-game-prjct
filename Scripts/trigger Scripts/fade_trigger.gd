extends Node2D


@export var fade_in = true




func _on_area_2d_body_entered(body):
	
	if body.name == "Main character":
		if !fade_in:
			$"../Main character/fade effect".fade_out()
		else:
			$"../Main character/fade effect".fade_in()
