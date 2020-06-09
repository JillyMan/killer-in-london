class_name HitBox
extends Area2D

export (Array, DamageProducer.DAMAGE_TYPE) var invul_damage_types : Array

export var health_points_node_path : NodePath
var health_points : HealthPoints

func _ready():
	connect("area_entered", self, "on_damage_producer_enter")
	health_points = get_node(health_points_node_path)
	pass

func on_damage_producer_enter(damage_producer : DamageProducer):
	if not damage_producer is DamageProducer:
		return
	
	if damage_producer.initiator == owner:
		return

	damage_producer.emit_signal("damage_produced")
	
	if invul_damage_types.has(damage_producer.damage_type):
		return
	
	health_points.take_damage(damage_producer)
	pass
