extends Node2D


@export var wait_for = 5.0
@export var change_look_right_to = false
@export var rotate_view_angle_offset_on_entry = 0
@export var rotate_view_angle_offset_on_exit = 0

func _on_area_2d_body_entered(body):

	if body.name == "military man":
		body.stop_for(wait_for)
		body.default_look_right = change_look_right_to
		#body.get_child("VisionCone2D").rotation_degrees +=rotate_view_angle_offset_on_entry
		for child in body.get_children():
			if child.get_name() == "VisionCone2D":
				child.rotation_degrees += rotate_view_angle_offset_on_entry
		
			
	


func _on_area_2d_body_exited(body):
	if body.name == "military man":
		#body.get_child("VisionCone2D").rotation_degrees +=rotate_view_angle_offset_on_exit
		for child in body.get_children():
			if child.get_name() == "VisionCone2D":
				child.rotation_degrees += rotate_view_angle_offset_on_exit
