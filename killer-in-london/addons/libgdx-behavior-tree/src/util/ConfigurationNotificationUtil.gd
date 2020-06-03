class_name ConfigurationNotificationUtil
extends Node


static func check_is_children_count_greater_than_zero(node : Node):
	if not node.get_child_count() > 0:
		return node.name + " should have at least one child"
	return null


static func check_is_node_has_exactly_one_child(node : Node):
	if not node.get_child_count() == 1:
		return node.name + " should have exactly one child"
	return ""


static func check_is_node_children_are_tasks(node : Node):
	for child in node.get_children():
		if not child is Task:
			return "One of children is not a task"
	return ""
