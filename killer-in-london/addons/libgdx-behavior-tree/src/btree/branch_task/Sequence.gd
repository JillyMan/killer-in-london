class_name Sequence, "res://addons/libgdx-behavior-tree/assets/icons/sequence_icon.png"
extends SingleRunningChildBranchTask

func _ready():
	._ready()


func on_child_failed(task):
	.on_child_failed(task)
	.fail()
	pass


func on_child_succeeded(task):
	.on_child_succeeded(task)
	self.current_child_idx += 1
	if self.current_child_idx < .get_child_count():
		.run()
	else:
		.success()
	pass
