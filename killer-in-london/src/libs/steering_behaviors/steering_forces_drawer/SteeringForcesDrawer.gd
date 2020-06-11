extends Node2D


export var enabled : = true
export var subject_node_path = @".."

onready var subject = get_node(subject_node_path)


func _process(delta):
	if not enabled:
		return
	
	update()
	pass


func _draw():
	draw_line(Vector2.ZERO, subject._velocity, Color.blue)
	draw_line(Vector2.ZERO, subject._steering, Color.green)
	pass
