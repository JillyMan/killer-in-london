tool
class_name Selector, "res://addons/libgdx-behavior-tree/assets/icons/selector_icon.png"
extends SingleRunningChildBranchTask


func on_child_succeeded(task):
	.on_child_succeeded(task)
	.success()
	pass


func on_child_failed(task):
	.on_child_failed(task)
	self.current_child_idx += 1
	
	if self.current_child_idx < .get_child_count():
		.run()
	else:
		.fail()
