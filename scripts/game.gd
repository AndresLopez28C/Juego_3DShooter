extends Node3D
@onready var label: Label = %Label

var score = 0
func increase_score():
	score+=1
	label.text = "Puntaje "+str(score) 


func _on_spawner_mob_spawned(mob):
	mob.die.connect(func on_mob_die():
		increase_score()
		get_poof(mob.global_position))##Humo cuando muere
	get_poof(mob.global_position)##Humo cuando sale


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == 'Player':
		get_tree().reload_current_scene.call_deferred()	

func get_poof(mob_global_position):
	const SMOKE_PUFF = preload("res://mob/smoke_puff/smoke_puff.tscn")
	var puff = SMOKE_PUFF.instantiate()
	add_child(puff)
	puff.global_position = mob_global_position
	
