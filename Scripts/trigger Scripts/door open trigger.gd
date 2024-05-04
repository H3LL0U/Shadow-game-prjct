extends Node2D

@export var allow_entry = ["detection"]
@export var open_door = true






	



func _on_area_2d_area_entered(area):
	
	for name in allow_entry:
		if area.name in name or name in area.name:
			
			$"..".visible = not open_door
