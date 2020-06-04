extends "res://src/entities/characters/ai/movable_ai/MovableAI.gd"


export var enemy_node_path : NodePath

onready var sign_ray_cast = $SignRayCast
onready var enemy = get_node(enemy_node_path)

onready var bt = $BehaviorTree
onready var sword = $Sword
onready var bow = $Bow

#TEMP OR PERSIST??????????
var enemy_last_seen_position


func _process(delta):
	bt.step()
	pass


func shoot():
	bow.use(global_position.direction_to(enemy.global_position))
	#print("shoot")
	pass


func melee_attack():
	sword.use(global_position.direction_to(enemy.global_position))
#	print("melee_attack")
	pass


func is_have_ammo() -> bool:
	return true
