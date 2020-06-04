extends Node2D


func use(direction):
	if not $AnimationPlayer.is_playing():
		rotation = direction.angle()
		$AnimationPlayer.play("attack")
	pass
