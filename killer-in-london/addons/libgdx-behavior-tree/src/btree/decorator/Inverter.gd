tool
class_name Inverter
extends Decorator


func on_child_succeeded(task):
	.on_child_failed(task)
	pass


func on_child_failed(task):
	.on_child_succeeded(task)
	pass
