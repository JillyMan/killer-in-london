tool
class_name Repeater, "res://addons/libgdx-behavior-tree/assets/icons/repeat_icon.png"
extends LoopDecorator

export var max_count : int  
var count_left 


func need_to_loop() -> bool:
	return loop and count_left > 0


func start():
	count_left = max_count
	pass


func on_child_succeeded(task):
	_handle_loop(task)
	pass


func on_child_failed(task):
	_handle_loop(task)
	pass


func _handle_loop(task):
	if count_left > 0:
		count_left -= 1
	
	if count_left == 0:
		.on_child_succeeded(task)
		loop = false
	else:
		loop = true
	pass
