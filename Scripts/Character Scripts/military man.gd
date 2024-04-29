extends CharacterBody2D
@export var speed = 50

var time :=0.0
var previous_coordinates : Vector2 =global_position
func _ready():
	$animation.play("idle")

var move_left = previous_coordinates.x-global_position.x>0
func _process(delta):
	
	time+=delta
	if $"..".name == "follow path":
		$"..".progress = time*speed
	$"..".rotation_degrees = 0
	$".".rotation_degrees = 0
	move_left = previous_coordinates.x-global_position.x>0
	#play animation
	
	if global_position != previous_coordinates:
		$animation.play("walk")
		if move_left and scale.x >0:
			scale.x *=-1
			
		if not move_left and scale.x<0:
			scale.x*=-1
	else:
		$animation.play("idle")
	previous_coordinates = global_position
		
			



func _on_detection_body_entered(body):
	if body.name == "Main character":
		if body.not_in_view == false:
			body.death()
