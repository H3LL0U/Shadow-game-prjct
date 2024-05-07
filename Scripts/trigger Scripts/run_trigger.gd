extends Node2D

var ref_to_body
var entred = true

func _on_area_2d_body_entered(body):
	if body.name == "Main character":
		ref_to_body = body
		entred = true
		body.activate_run_cutscene("right")

