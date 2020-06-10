extends "res://src/entities/characters/enemies/base_enemy/BaseEnemy.gd"


onready var bow = $Bow


func _apply_behavior():
	$BehaviorTree.step()
	pass


func attack(direction):
	bow.rotation = direction.angle()
	bow.use(self, direction)
	pass


func death():
	$BloodEffect.restart()
	$BloodEffect.emitting = true
	pass
