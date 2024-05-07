extends CharacterBody2D


@export var speed = 175.0
@export var sprint_mul = 1.5
@export var stamina = 2
@export var stamina_recovery_multiplier=2
@export var stamina_recovery_walking_multiplier = 0.50
@export var stamina_cooldown = 1
@export var enable_cam = true
@export var enable_move = true
@export var enable_open_settings = true


var in_cutscene = []
var current_sprint_mul = 1.0
var is_moving = false
var current_stamina = stamina
var current_stamina_cooldown = stamina_cooldown
var look_right = true
var is_running = false
var not_in_view = false

@export var is_dead = false
func death():
	enable_move = false
	is_dead = true
	#get_tree().reload_current_scene()
	
	$animation.play("surrender")
	$"main camera/death_window".visible = true
func win():
	enable_move = false
	$"main camera/Win window".visible = true
func activate_run_cutscene(where_to_run):
	enable_move = false
	in_cutscene = [true, where_to_run]
	
func _physics_process(delta: float) -> void:
	# Running logic
	is_moving = Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or in_cutscene
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
	
	elif in_cutscene:
		if in_cutscene[1] == "right":
			look_right = true
			self.position.x+=speed *delta*current_sprint_mul
			
			
	
	

	
	move_and_slide()
func _process(_delta):
	#update UI
	$stamina.value=current_stamina/stamina*100
	if $stamina.value == 100:
		$stamina.visible = false
	else:
		$stamina.visible = true
	if Input.is_action_just_pressed("settings_open") and enable_open_settings:
		$"main camera/settings".visible = not $"main camera/settings".visible
		
	
	#Update animation
	if enable_move or in_cutscene:
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
	elif not is_dead:
		$animation.play("idle")
	#resetting the velocity that might be caused by a collision with another object
	velocity = Vector2.ZERO
	


#update the hiding of the player
func _on_hiding_area_body_entered(_body):
	not_in_view = true
	$Sprite2D.modulate = Color(1,1,1,0.5)


func _on_hiding_area_body_exited(_body):
	not_in_view = false
	$Sprite2D.modulate = Color(1,1,1,1)
	
