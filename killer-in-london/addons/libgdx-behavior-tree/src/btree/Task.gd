tool
class_name Task
extends Node

enum Status {
	FRESH,
	RUNNING,
	FAILED,
	SUCCEEDED,
	CANCELLED
}

var current_status = Status.FRESH
var previous_status 

var tree = null
var parent_task : Task


func success():
	previous_status = current_status
	current_status = Status.SUCCEEDED
	if parent_task:
		parent_task.on_child_succeeded(self) 
	end()
	pass


func fail():
	previous_status = current_status
	current_status = Status.FAILED
	if parent_task:
		parent_task.on_child_failed(self) 
	end()
	pass


func running():
	previous_status = current_status
	current_status = Status.RUNNING
	if parent_task:
		parent_task.on_child_running(self) 
	pass


func cancel():
	cancel_running_children()
	previous_status = current_status
	current_status = Status.CANCELLED
	end()
	pass


func cancel_running_children(from_idx=0):
	for i in range(from_idx, get_child_count()):
		var child = get_child(i)
		if child.current_status == Status.RUNNING:
			child.cancel()
		pass
	pass


func reset():
	if current_status == Status.RUNNING:
		cancel()
	
	for child in get_children():
		child.reset()
	
	current_status = Status.FRESH
	parent_task = null
	pass


#abstract methods
func run():
	pass


func start():
	pass


func end():
	pass


func on_child_succeeded(task : Task):
	pass


func on_child_failed(task : Task):
	pass


func on_child_running(task : Task):
	pass
