extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Main character/animation".play("idle")
	$music_player.load_song("Main_menu")
	


