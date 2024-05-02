extends Node2D


var in_reach = false

func _on_opening_sector_body_entered(body):
	if body.name == "Main character":
		in_reach = true



func _on_opening_sector_body_exited(body):
	if body.name == "Main character":
		in_reach = false
func _process(_delta):
	if Input.is_action_just_pressed("use") and in_reach and get_child_count()<2:
		queue_free()
		
