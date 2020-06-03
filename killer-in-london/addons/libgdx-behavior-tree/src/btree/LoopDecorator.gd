class_name LoopDecorator
extends Decorator

var loop 


func run():
	loop = true
	
	while need_to_loop():
		._handle_child()
	pass


func on_child_running(task):
	.on_child_running(task)
	loop = false
	pass


#virtual method
func need_to_loop()->bool:
	return loop
