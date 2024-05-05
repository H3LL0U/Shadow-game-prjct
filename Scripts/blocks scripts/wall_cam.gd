extends Node2D

@export var view_length = 200
@export var view_angle_offset = 0
@export var view_angle = 90
func _ready():
	
	$VisionCone2D.angle_deg = view_angle
	$VisionCone2D.max_distance = view_length
	$VisionCone2D.rotation_degrees = view_angle_offset




