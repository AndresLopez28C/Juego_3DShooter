extends RigidBody3D
@onready var bat_model: Node3D = %bat_model

func _take_damage():
	bat_model._hurt()
