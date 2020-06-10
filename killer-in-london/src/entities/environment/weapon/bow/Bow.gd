extends Node2D

export var gkd := 1.0
export var projectile_packed_scene : PackedScene

onready var timer = $Timer


func use(emitter, direction):
	if timer.time_left > 0:
		return
	
	timer.start(gkd)
	var projectiles : Node = get_tree().current_scene.projectiles
	var projectile_instance : Node2D = projectile_packed_scene.instance()
	
	projectile_instance.direction = direction
	projectiles.add_child(projectile_instance)
	
	projectile_instance.global_position = emitter.global_position
	pass
