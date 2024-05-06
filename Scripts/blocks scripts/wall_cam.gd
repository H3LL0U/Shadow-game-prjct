extends Node2D

@export var view_length = 200
@export var view_angle_offset = 0
@export var view_angle = 90
@export var awareness_meter = 0.3
@export var turn_on_for = 3
@export var turn_off_for = 2

var turn_on_counter = turn_on_for
var turn_off_counter = turn_off_for

var cam_on = true
var entred = false
var refference_to_entred_player = null
var current_awareness = awareness_meter
func _ready():
	
	$VisionCone2D.angle_deg = view_angle
	$VisionCone2D.max_distance = view_length
	$VisionCone2D.rotation_degrees = view_angle_offset



func _process(delta):
	if cam_on:
		$VisionCone2D/Area2D/CollisionPolygon2D.disabled = false
		$VisionCone2D/Polygon2D.modulate = Color(1,1,1,1)
		turn_on_counter-=delta
		
		if turn_on_counter<=0:
			cam_on = false
			turn_off_counter = turn_off_for
	else:
		$VisionCone2D/Area2D/CollisionPolygon2D.disabled = true
		$VisionCone2D/Polygon2D.modulate = Color(1,1,1,0)
		turn_off_counter-=delta
		if turn_off_counter<=0:
			cam_on = true
			turn_on_counter = turn_on_for
		
	
	
	
	$"!".modulate = Color(1,1,1,1-current_awareness/awareness_meter)
	if entred:
		current_awareness-=delta
	else:
		current_awareness +=delta
		if current_awareness > awareness_meter:
			current_awareness = awareness_meter
	
	if current_awareness <= 0 and refference_to_entred_player!= null:
		refference_to_entred_player.death()


func _on_area_2d_body_entered(body):
	if body.name == "Main character":
		entred = true
		refference_to_entred_player = body
		
		
		


func _on_area_2d_body_exited(body):
	if body.name == "Main character":
		entred = false
		
