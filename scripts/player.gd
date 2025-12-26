extends CharacterBody3D

var speed = 50.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.5 # movemos todooo el nodo, no solo la camara
		## get_node("Camera3D")
		## $Camera3D/gun_model
		## %gun_model
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x,-80,80)
	elif event.is_action("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
