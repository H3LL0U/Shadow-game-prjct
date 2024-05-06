extends Node2D

@export var texts = ["sdadasdadsdsadassddsadadssdswawsdwas"]
@export var authors = [""]
@export var delete_after = -1
@export var activate_immediately = true

var entred = false

func send_text():
	$"../Main character".enable_move = false
			
	$"../Main character/main camera/text_box".text_buffer=texts.duplicate()
	$"../Main character/main camera/text_box".author_buffer= authors.duplicate()
	$"../Main character/main camera/text_box".start = true

			
	$"../Main character/main camera/text_box".visible = true
	delete_after -=1
	if delete_after==0:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Main character":
		entred = true
		
		
		if activate_immediately :
			send_text()
		





func _on_area_2d_body_exited(body):
	if body.name == "Main character":
		entred = false
func  _process(_delta):
	if entred and not activate_immediately and Input.is_action_just_pressed("use"):
		
		send_text()
