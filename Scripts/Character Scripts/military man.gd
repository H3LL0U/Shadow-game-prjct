extends CharacterBody2D
@export var speed = 50
@export var view_length = 200
@export var view_angle = 90
@export var awareness_meter = 0.3
@export var view_angle_offset = -90
var current_awareness = awareness_meter
var refference_to_main_chr = null
var chr_in_view = false
var time :=0.0
var previous_coordinates : Vector2 =global_position
var direction
var stop = false
func _ready():
	$animation.play("idle")
	$VisionCone2D.angle_deg = view_angle
	$VisionCone2D.max_distance = view_length
	$VisionCone2D.rotation_degrees = view_angle_offset
var move_left = previous_coordinates.x-global_position.x>0
func _process(delta):
	
	
	time+=delta
	if $"..".name == "follow path" and not stop:
		$"..".progress = time*speed
	

	
	$"..".rotation_degrees = 0
	
	$".".rotation_degrees = 0

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
	if current_awareness <0 and refference_to_main_chr!=null:
		refference_to_main_chr.death()
		stop = true
	if chr_in_view and refference_to_main_chr.not_in_view == false:
		current_awareness-=delta
	else:
		if awareness_meter>current_awareness:
			current_awareness+=delta
		if awareness_meter<current_awareness:
			current_awareness = awareness_meter
	$"Sprite2D/!".modulate = Color(1,1,1,1-(current_awareness/awareness_meter))



func _on_detection_body_entered(body):
	if body.name == "Main character":
		chr_in_view = true
		refference_to_main_chr = body

func _on_area_2d_body_entered(body):
	if body.name == "Main character":
		chr_in_view = true
		refference_to_main_chr = body
		
func _on_detection_body_exited(body):
	if body.name == "Main character":
		chr_in_view = false



func _on_area_2d_body_exited(body):
	if body.name == "Main character":
		chr_in_view = false
