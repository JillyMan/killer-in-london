tool
class_name AlwaysRunning
extends Decorator


func on_child_succeeded(task):
	.on_child_running(task)
	pass


func on_child_failed(task):
	.on_child_running(task)
	pass
