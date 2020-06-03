tool
class_name Includer, "res://addons/libgdx-behavior-tree/assets/icons/condition_icon.png"
extends Decorator



func run():
	var child = get_child(0)
	child.root_task.parent_task = self
	child.step()
	pass
