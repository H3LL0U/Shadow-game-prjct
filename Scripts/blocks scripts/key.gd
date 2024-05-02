extends Node2D



func _on_area_2d_body_entered(body):
	if body.name == "Main character":
		$".".queue_free()
