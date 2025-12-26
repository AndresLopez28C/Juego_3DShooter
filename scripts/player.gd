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
		
func _process(delta: float) -> void:
	const speed =5.5
	var input_direction2d = Input.get_vector("Izquierda","Derecha","Adelante","Atras")
	var input_direction3d = Vector3(input_direction2d.x,0.0,input_direction2d.y)
	## velocity = input_direction3d * speed
	var direction = transform.basis * input_direction3d
	velocity.x= direction.x*speed
	velocity.z= direction.z*speed
	velocity.y -=20 * delta
	if Input.is_action_just_pressed("Saltar") and is_on_floor():
		velocity.y = 10
	elif Input.is_action_just_released("Saltar") and velocity.y>0:
		velocity.y=0
	
	move_and_slide()
	if Input.is_action_just_pressed("Disparar"):
		_shoot_bullet()
	
func _shoot_bullet():
	const BULLET3D = preload("res://player/bullet.tscn")
	var new_bullet = BULLET3D.instantiate()
	%Marker3D.add_child(new_bullet)
	new_bullet.global_transform = %Marker3D.global_transform
