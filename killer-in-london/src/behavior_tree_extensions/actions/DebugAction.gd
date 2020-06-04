class_name DebugAction
extends LeafTask


export var message : = ""
export(Task.Status) var return_status


func execute() -> int:
	print(message)
	return return_status
