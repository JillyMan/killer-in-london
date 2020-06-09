class_name DamageProducer
extends Area2D

enum DAMAGE_TYPE {lava, bulllet, lazer, punch, arrow, sword}

signal damage_produced

export(DAMAGE_TYPE) var damage_type = DAMAGE_TYPE.bulllet
export var damage_value : int = 1
#export var initiator_path : NodePath

onready var initiator = owner
