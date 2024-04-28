extends CharacterBody2D


@export var speed = 175.0
@export var sprint_mul = 1.5
@export var stamina = 2
@export var stamina_recovery_multiplier=2
@export var stamina_recovery_walking_multiplier = 0.50
@export var stamina_cooldown = 1
@export var enable_cam = true
@export var enable_move = true
# Get the gravity from the project settings to be synced with RigidBody nodes.


var current_sprint_mul = 1.0
var is_moving = false
var current_stamina = stamina
var current_stamina_cooldown = stamina_cooldown
var look_right = true
var is_running = false

func _physics_process(delta: float) -> void:
	# Running logic
	is_moving = Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
	if enable_move:
		if Input.is_action_pressed("sprint") and current_stamina >=0 and is_moving:
			current_sprint_mul = sprint_mul
			current_stamina-=delta
			current_stamina_cooldown = stamina_cooldown
			is_running = true
			
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
			look_right = false
			self.position.x-=speed*delta*current_sprint_mul
		if Input.is_action_pressed("move_right"):
			look_right = true
			self.position.x+=speed *delta*current_sprint_mul
	

	
	

	
	move_and_slide()
func _process(delta):
	#update UI
	$UI/stamina.value=current_stamina/stamina*100
	if $UI/stamina.value == 100:
		$UI/stamina.visible = false
	else:
		$UI/stamina.visible = true
		
	
	#Update animation
	if enable_move:
		if not is_moving:
			$animation.play("idle")
		else:
			
			$animation.play("walk")
			if is_running:
				$animation.speed_scale = current_sprint_mul
				
		
		
		if look_right and  $Sprite2D.scale.x<0:
			$Sprite2D.scale.x*=-1
			
		elif not look_right and $Sprite2D.scale.x>0:
			$Sprite2D.scale.x*=-1
func display_text(txt = ""):
	pass
	
	
