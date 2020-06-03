tool
class_name Waiter, "res://addons/libgdx-behavior-tree/assets/icons/wait_icon.png"
extends Decorator

export var wait_time := 0.0
var remaining_time := 0.0


func start():
	remaining_time = wait_time
	pass


func run():
	remaining_time -= get_process_delta_time()
	if remaining_time > 0:
		running()
		return
	_handle_child()
	pass
