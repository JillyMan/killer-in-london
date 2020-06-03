tool
class_name BranchTask, "res://addons/libgdx-behavior-tree/assets/icons/branch_task.png"
extends Task


func _get_configuration_warning():
	var validation_result
	 
	validation_result = ConfigurationNotificationUtil.check_is_children_count_greater_than_zero(self)
	
	if validation_result:
		return validation_result
	
	validation_result = ConfigurationNotificationUtil.check_is_node_children_are_tasks(self)
	
	if validation_result:
		return validation_result
	
	return ""
