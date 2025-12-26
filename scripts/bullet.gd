extends Area3D
const SPEED = 25.0
const rangeb = 50.0
var traveled_distance = 0.0

func _physics_process(delta: float) -> void:
	position += -transform.basis.z * SPEED* delta
	traveled_distance += delta*SPEED
	if traveled_distance > rangeb:
		queue_free()
		


func _on_body_entered(body: Node3D) -> void:
	if body.has_method("_take_damage"):
		body._take_damage()
	queue_free()
