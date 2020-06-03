tool
class_name Decorator, "res://addons/libgdx-behavior-tree/assets/icons/decorator.png"
extends Task


func run():
	_handle_child()
	pass


func _handle_child():
	#can be passed into property
	var child = get_child(0)
	
	if child.current_status == Status.RUNNING:
		child.run()
	else:
		_handle_not_running_child(child)
	pass


func _handle_not_running_child(child):
	child.parent_task = self
	child.start()
	child.run()
	pass


func on_child_running(task):
	running()
	pass


func on_child_succeeded(task):
	success()
	pass


func on_child_failed(task):
	fail()
	pass


func _get_configuration_warning():
	var validation_result
	 
	validation_result = ConfigurationNotificationUtil.check_is_node_has_exactly_one_child(self)
	
	if validation_result:
		return validation_result
	
	validation_result = ConfigurationNotificationUtil.check_is_node_children_are_tasks(self)
	
	if validation_result:
		return validation_result
	
	return ""
