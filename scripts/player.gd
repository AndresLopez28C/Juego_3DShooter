extends CharacterBody3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print(name)
	
func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion :
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
	if Input.is_action_pressed("Disparar") and %Timer.is_stopped():
		_shoot_bullet()
		
	var joy_right_x = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	var joy_right_y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
	# Sensibilidad del joystick (ajusta estos valores a tu gusto)
	var sensitivity = 100.0
	
	# Aplicar rotación similar al mouse
	if abs(joy_right_x) > 0.1 or abs(joy_right_y) > 0.1:  # Zona muerta
		print(joy_right_x)
		print(joy_right_y)
		#rotation_degrees.y = joy_right_x * sensitivity
		%Camera3D.rotation_degrees.x= joy_right_x * sensitivity 
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -80, 80)
	
func _shoot_bullet():
	const BULLET3D = preload("res://player/bullet.tscn")
	var new_bullet = BULLET3D.instantiate()
	%Marker3D.add_child(new_bullet)
	new_bullet.global_transform = %Marker3D.global_transform
	%Timer.start()
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("disparo")
