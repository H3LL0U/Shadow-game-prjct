extends Camera2D

@export var zoom_value = 0.2
@export var max_zoom = 3
@export var min_zoom = 1


func _process(_delta):
	self.enabled = $"..".enable_cam
	if Input.is_action_just_pressed("zoom_in") and max_zoom>= self.zoom.x:
		self.zoom.x+=zoom_value
		self.zoom.y+=zoom_value

	if Input.is_action_just_pressed("zoom_out") and min_zoom<=self.zoom.x:
		self.zoom.x-=zoom_value
		self.zoom.y-=zoom_value
	scale = Vector2(1 / zoom.x, 1 / zoom.y)
		
	
	
