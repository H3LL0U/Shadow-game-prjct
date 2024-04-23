extends CharacterBody2D


@export var speed = 300.0
@export var sprint_mul = 1.5

# Get the gravity from the project settings to be synced with RigidBody nodes.


var current_sprint_mul = 1

func _physics_process(delta: float) -> void:
	# Get input vector
	if Input.is_action_pressed("sprint"):
		current_sprint_mul = sprint_mul
	else:
		current_sprint_mul = 1
	if Input.is_action_pressed("move_up"):
		self.position.y-=speed*delta*current_sprint_mul
	if Input.is_action_pressed("move_down"):
		self.position.y+=speed*delta*current_sprint_mul
	if Input.is_action_pressed("move_left"):
		self.position.x-=speed*delta*current_sprint_mul
	if Input.is_action_pressed("move_right"):
		self.position.x+=speed *delta*current_sprint_mul
	

	# Normalize input vector to ensure consistent speed in all directions
	

	# Move the character
	move_and_slide()

