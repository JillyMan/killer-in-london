extends "res://src/entities/characters/ai/movable_ai/MovableAI.gd"


export var enemy_node_path : NodePath

onready var sign_ray_cast = $SignRayCast
onready var enemy = get_node(enemy_node_path)

#TEMP OR PERSIST??????????
var enemy_last_seen_position


func _process(delta):
	$BehaviorTree.step()
	pass


func shoot():
	print("shoot")
	pass


func melee_attack():
	print("melee_attack")
	pass
