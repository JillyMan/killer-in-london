class_name HealthPoints
extends Node

signal damage_taken

export var hp : int = 1

export var subject_node_path : NodePath
var subject : Node


func _ready():
	subject = get_node(subject_node_path)


func take_damage(damage_producer : DamageProducer):
	hp -= damage_producer.damage_value
	emit_signal("damage_taken")
	
	if hp <= 0:
		subject.death()
