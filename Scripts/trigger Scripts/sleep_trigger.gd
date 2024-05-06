extends Node2D

var ref_to_obj
var is_asleep

@export var make_sleep_for = 2.0
@export var reset_after = 3.0

var reset_counter = reset_after
var make_sleep_counter = make_sleep_for


@export var reseting = true

var entred = false

func _process(delta):
	if reseting:
		reset_counter -= delta
		if reset_counter <=0:
			make_sleep_counter = make_sleep_for
			reseting = false
	else:
		if entred:
			make_sleep_counter-=delta
			ref_to_obj.make_sleep()
		if make_sleep_counter<=0:
			reset_counter = reset_after
			reseting = true
			ref_to_obj.make_awake()
			
		
		 

func _on_area_2d_body_entered(body):
	if "military man" in  body.name:
		ref_to_obj = body
		entred = true

func _on_area_2d_body_exited(body):
	if "military man" in  body.name:
		entred = false
		
