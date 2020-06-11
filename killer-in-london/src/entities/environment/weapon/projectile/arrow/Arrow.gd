extends KinematicBody2D

export var speed := 100
var direction : Vector2


func _ready():
	rotation = direction.angle()
	

func _physics_process(delta):
	var col = move_and_collide(direction * (speed * delta))
	if col:
		direction = Vector2.ZERO
		$CollisionShape2D.set_deferred("disabled", true)
		$DamageProducer/CollisionShape2D.set_deferred("disabled", true)
	pass
