extends Sprite2D
@export var cut = false
var uncut_texture = Texture
var cut_texture = Texture

func _ready():
	uncut_texture = load("res://assets/sprites/blocks/fence.png")
	cut_texture = load("res://assets/sprites/blocks/fence_cut.png")

func _process(_delta):
	if cut:
		self.texture = cut_texture
	else:
		self.texture = uncut_texture
		
