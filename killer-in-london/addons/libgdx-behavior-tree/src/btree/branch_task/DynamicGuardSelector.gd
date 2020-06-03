class_name DynamicGuardSelector, "res://addons/libgdx-behavior-tree/assets/icons/dynamic_guard_selector.png"
extends BranchTask

export var reset_task_if_guard_failed := false

var running_child


func run():
	var child_to_run
	
	for task in get_children():
		if _check_guard(task):
			child_to_run = task
			break
		elif reset_task_if_guard_failed:
			task.reset()

	if running_child and not running_child == child_to_run:
		running_child.cancel()
		running_child = null
	
	if not child_to_run:
		.fail()
	else:
		if not running_child:
			running_child = child_to_run
			running_child.parent_task = self
			running_child.start()
		running_child.run()
	pass


func _check_guard(task):
	if not task is GuardDecorator:
		return true 
	return task.check_condition()


func on_child_succeeded(task):
	.on_child_succeeded(task)
	running_child = null
	pass


func on_child_failed(task):
	.on_child_failed(task)
	running_child = null
	pass


func on_child_running(task):
	.on_child_running(task)
	running_child = task
	pass


func reset():
	.reset()
	running_child = null
	pass
