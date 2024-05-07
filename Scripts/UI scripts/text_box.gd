extends Node2D

@onready var settings_vars = get_node("/root/SettingsVars")
@export var text_to_add = ""
var current_text_speed =34
var default_current_text_speed=34
var text_delay_punctuation = {
	"!":0.15,
	".":0.15,
	",":0.10,
	"—":0.5,
	"?":0.15
}
var author_sprites = {
	"You":preload("res://assets/sprites/Characters/main_character/stationary no borders guy.png"),
	"Patrol Guard":preload("res://assets/sprites/Characters/military man/static military man.png"),
	"Surveillance Guard": preload("res://assets/sprites/Characters/military man/static military man.png")
}
#contains lists which contains 2 parameters: author, text
@export var text_buffer = []
@export var author_buffer = []
@export var start = false
func change_text (speaker :String = "NONE" ,newtext: String="NONE", text_speed_ms: float = 34.0, initial_delay: float = 0):
	
		
		#if newtext!="NONE":
			#$text_box/Sprite2D/Label_text.text= newtext
	$Label_text.text =""
	text_to_add = newtext
	default_current_text_speed = text_speed_ms/1000
	current_text_speed = initial_delay
	if speaker!="NONE":
		$Label_name.text =speaker
		


func _process(delta):
	#let letters manualy appear
	if Input.is_action_just_pressed("skip_all_dialogue"):
		text_buffer = []
		text_to_add = ""
		if not $"../..".is_dead and not $"../..".in_cutscene :
			$"../..".enable_move = true
		self.visible = false 
		
	current_text_speed-=delta
	if text_to_add!="" and current_text_speed<=0:
		current_text_speed = default_current_text_speed
		if text_to_add[0] in text_delay_punctuation:
			current_text_speed+=text_delay_punctuation[text_to_add[0]]
		$Label_text.text+=text_to_add[0]
		text_to_add = text_to_add.substr(1)
		$speaker.play()
	#cycle through text
	if Input.is_action_just_pressed("next") and text_to_add != "":
		$Label_text.text +=text_to_add
		text_to_add = ""
	
	elif text_buffer and Input.is_action_just_pressed("next") or start and text_buffer:
		change_text(author_buffer[0],text_buffer[0])
		if author_buffer[0] in author_sprites:
			$author_sprite.texture = author_sprites[author_buffer[0]]
		
		else:
			var existing_name = false
			for author_name in author_sprites:
				if author_buffer[0] in author_name or author_name in author_buffer[0] :
					$author_sprite.texture = author_sprites[author_name]
					existing_name = true
			if not existing_name:
				$author_sprite.texture = null
		text_buffer.pop_front()
		author_buffer.pop_front()
		start = false
		
	elif !text_buffer and Input.is_action_just_pressed("next"):
		if not $"../..".is_dead and not $"../..".in_cutscene :
			$"../..".enable_move = true
		self.visible = false 
	
	#Update volume
	$speaker.volume_db = settings_vars.max_db_sfx-settings_vars.min_db_sfx*(settings_vars.db_general/100*settings_vars.db_sfx/100)+settings_vars.min_db_sfx
	if settings_vars.db_general == 0 or settings_vars.db_sfx == 0:
		$speaker.volume_db = -99999999
