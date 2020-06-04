extends KinematicBody2D

var direction : Vector2

func _ready():
	rotation = direction.angle()
	

func _physics_process(delta):
	move_and_slide(direction * 100)
	pass
