extends AudioStreamPlayer

@onready var settings_vars = get_node("/root/SettingsVars")

@onready var songs = {
	"Main_menu" : load("res://assets/sounds/Music/BoxCat Games - Defeat.mp3"),
	"Gameplay": load("res://assets/sounds/Music/BoxCat Games - Trace Route.mp3"),
	"Victory": load("res://assets/sounds/Music/BoxCat Games - Victory.mp3")
}
func _ready():
	load_song("Gameplay")

func _process(_delta):
	volume_db = settings_vars.max_db_music-settings_vars.min_db_music*(settings_vars.db_general/100*settings_vars.db_music/100)+settings_vars.min_db_music
	if settings_vars.db_general == 0 or settings_vars.db_music == 0:
		volume_db = -99999999
func load_song(song_name):
	stream = songs[song_name]
	play()
