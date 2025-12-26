extends RigidBody3D
@onready var bat_model: Node3D = %bat_model
@onready var player = get_node("/root/Game/Player")
const speed = 3.0
func _take_damage():
	bat_model._hurt()
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	direction.y=0.0
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP)
