extends Node2D


@export var wait_for = 5.0
@export var change_look_right_to = false



func _on_area_2d_body_entered(body):

	if body.name == "military man":
		body.stop_for(wait_for)
		body.default_look_right = change_look_right_to
			
	
