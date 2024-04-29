extends Node2D

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
	"Border patrol":preload("res://assets/sprites/Characters/military man/static military man.png")
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
			$author_sprite.texture = null
		text_buffer.pop_front()
		author_buffer.pop_front()
		start = false
		
	elif !text_buffer and Input.is_action_just_pressed("next"):
		if not $"../..".is_dead:
			$"../..".enable_move = true
		self.visible = false
		
