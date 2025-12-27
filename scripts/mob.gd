extends RigidBody3D
@onready var bat_model: Node3D = %bat_model
@onready var player = get_node("/root/Game/Player")
@onready var timer: Timer = %Timer
signal die()

var health = 3
const speed = 3.0
func _take_damage():
	if health==0:
		return
	health -=1
	%Damage.play()
	bat_model._hurt()
	if health==0:
		timer.start()
		%KO.play()
		set_physics_process(false)
		gravity_scale=1.0
		var direction = player.global_position.direction_to(global_position)
		var random_upward_force = Vector3.UP * randf() * 5.0
		apply_central_impulse(direction.rotated(Vector3.UP, randf_range(-0.2, 0.2)) * 10.0 + random_upward_force)
		timer.start()
		
		
		
		
func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	direction.y= 0.0
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI


func _on_timer_timeout() -> void:
	queue_free()
	die.emit()
