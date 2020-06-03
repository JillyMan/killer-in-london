tool
class_name SingleRunningChildBranchTask
extends BranchTask

var running_child
var current_child_idx = 0
var child_indexes_queue


func _ready():
	child_indexes_queue = range(get_child_count())
	pass


func start():
	current_child_idx = 0


func reset():
	current_child_idx = 0


func run():
	if running_child:
		running_child.run()
	else:
		running_child = .get_child(child_indexes_queue[current_child_idx])
		running_child.parent_task = self
		running_child.start()
		running_child.run()
		pass
	pass


func on_child_succeeded(task):
	.on_child_succeeded(task)
	running_child = null
	pass


func on_child_failed(task):
	.on_child_failed(task)
	running_child = null
	pass
