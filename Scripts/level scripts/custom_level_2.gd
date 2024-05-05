extends Node2D
var rng = RandomNumberGenerator.new()
var move_key_x = rng.randi_range(0,2)
var move_key_y = rng.randi_range(0,2)

func _ready():
	$door5/key.position.x += (move_key_x*2540)
	$door6/key.position.x += (move_key_x*2540)
	$text_trigger.position.x += (move_key_x*205)
	$text_trigger.position.y +=(move_key_y*205)
	$door5/key.position.y += (move_key_y*2540)
	$door6/key.position.y += (move_key_y*2540)
	
