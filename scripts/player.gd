extends CharacterBody3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.2 # movemos todooo el nodo, no solo la camara
		## get_node("Camera3D")
		## $Camera3D/gun_model
		## %gun_model
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x,-80,80)
	elif event.is_action("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func _process(_delta: float) -> void:
	const speed =5.5
	var input_direction2d = Input.get_vector("Izquierda","Derecha","Adelante","Atras")
	var input_direction3d = Vector3(input_direction2d.x,0.0,input_direction2d.y)
	## velocity = input_direction3d * speed
	var direction = transform.basis * input_direction3d
	velocity.x= direction.x*speed
	velocity.z= direction.z*speed
	move_and_slide()
