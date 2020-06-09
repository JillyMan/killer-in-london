extends "res://src/entities/characters/enemies/base_enemy/BaseEnemy.gd"
 
export var attack_offset := 32.0
export var attack_time := 1.0

onready var attack_fsm = $AttackFSM
onready var body = $Body
onready var damage_producer_shape = $CollisionShape2D


func _process(delta):
	attack_fsm.handle_process(delta)


func _apply_behavior():
	$BehaviorTree.step()


func attack(direction):
	var target_position = direction * global_position.distance_to(enemy.global_position)
	attack_fsm.set_state($AttackFSM/Attack, false, {"target_position":target_position})
	pass

