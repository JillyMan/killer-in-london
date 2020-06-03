class_name GuardDecorator, "res://addons/libgdx-behavior-tree/assets/icons/guard_icon.png"
extends Decorator


func check_condition() -> bool:
	return true


func _handle_not_running_child(child):
	child.parent_task = self
	child.start()
	
	if check_condition():
		child.run()
	else:
#		child.cancel()
		child.reset()
		child.fail()
	pass
