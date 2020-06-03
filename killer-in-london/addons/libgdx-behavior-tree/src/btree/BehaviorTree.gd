tool
class_name BehaviorTree, "res://addons/libgdx-behavior-tree/assets/icons/root_icon.png"
extends Task

export var host_node_path : NodePath

var host
var root_task


func _ready():
	root_task = .get_child(0)
	set_tree_to_children_recursively(root_task)
	host = get_node(host_node_path)
	pass


func set_tree_to_children_recursively(task):
	task.tree = self
	for child in task.get_children():
		set_tree_to_children_recursively(child)
	pass 


func step():
	if root_task.current_status == self.Status.RUNNING:
		root_task.run()
	else:
#		root_task.parent_task = self
		root_task.start()
		root_task.run()
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
