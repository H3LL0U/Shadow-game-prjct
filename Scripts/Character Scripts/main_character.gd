extends CharacterBody2D


@export var speed = 175.0
@export var sprint_mul = 1.5
@export var stamina = 2
@export var stamina_recovery_multiplier=2
@export var stamina_recovery_walking_multiplier = 0.50
@export var stamina_cooldown = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.


var current_sprint_mul = 1
var is_moving = false
var current_stamina = stamina
var current_stamina_cooldown = stamina_cooldown
func _physics_process(delta: float) -> void:
	# Running logic
	is_moving = Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
	if Input.is_action_pressed("sprint") and current_stamina >=0 and is_moving:
		current_sprint_mul = sprint_mul
		current_stamina-=delta
		current_stamina_cooldown = stamina_cooldown
		
	elif not is_moving:
		current_sprint_mul = 1
		current_stamina_cooldown -=delta
		if current_stamina_cooldown <=0 and current_stamina<stamina:
			current_stamina +=delta*stamina_recovery_multiplier
	else:
		current_stamina_cooldown -=delta*stamina_recovery_walking_multiplier
		current_sprint_mul = 1
		if current_stamina_cooldown <=0 and current_stamina<stamina:
			current_stamina+=delta*stamina_recovery_multiplier*stamina_recovery_walking_multiplier
	#moving logic
	if Input.is_action_pressed("move_up"):
		self.position.y-=speed*delta*current_sprint_mul
	if Input.is_action_pressed("move_down"):
		self.position.y+=speed*delta*current_sprint_mul
	if Input.is_action_pressed("move_left"):
		self.position.x-=speed*delta*current_sprint_mul
	if Input.is_action_pressed("move_right"):
		self.position.x+=speed *delta*current_sprint_mul
	

	
	

	# Move the character
	move_and_slide()
func _process(delta):
	$"main camera/UI/stamina".value=current_stamina/stamina*100
	if $"main camera/UI/stamina".value == 100:
		$"main camera/UI/stamina".visible = false
	else:
		$"main camera/UI/stamina".visible = true
	
