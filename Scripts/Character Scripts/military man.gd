extends CharacterBody2D
@export var speed = 50
@export var view_length = 200
@export var view_angle = 90
var time :=0.0
var previous_coordinates : Vector2 =global_position
var direction
var stop = false
func _ready():
	$animation.play("idle")
	$VisionCone2D.angle_deg = view_angle
	$VisionCone2D.max_distance = view_length
var move_left = previous_coordinates.x-global_position.x>0
func _process(delta):
	
	
	time+=delta
	if $"..".name == "follow path" and not stop:
		$"..".progress = time*speed
	print(direction)

	
	$"..".rotation_degrees = 0
	
	$".".rotation_degrees = 0
	#if move_left and $VisionCone2D.rotation_degrees<0:
		#$VisionCone2D.rotation_degrees*=-1
	#elif not move_left and $VisionCone2D.rotation_degrees>0:
		#$VisionCone2D.rotation_degrees*=-1
	move_left = previous_coordinates.x-global_position.x>0
	#play animation
	
	if global_position != previous_coordinates:
		$animation.play("walk")
		if move_left and scale.x >0:
			scale.x *=-1
			$VisionCone2D.rotation_degrees*=-1
			
			
		if not move_left and scale.x<0:
			scale.x*=-1
			$VisionCone2D.rotation_degrees*=-1
			
	else:
		$animation.play("idle")
	previous_coordinates = global_position
		
			



func _on_detection_body_entered(body):
	if body.name == "Main character":
		if body.not_in_view == false:
			stop = true
			body.death()
			


func _on_area_2d_body_entered(body):
	if body.name == "Main character":
		if body.not_in_view == false:
			stop = true
			body.death()
	



