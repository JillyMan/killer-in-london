class_name LeafTask, "res://addons/libgdx-behavior-tree/assets/icons/action_icon.png"
extends Task


func execute() -> int:
	return self.Status.FAILED


func run():
	var result = execute()
	
	if result == self.Status.SUCCEEDED:
		.success()
	elif result == self.Status.FAILED:
		.fail()
	elif result == self.Status.RUNNING:
		.running()
	else:
		push_error("Illegal execution result: " + result)
	pass
