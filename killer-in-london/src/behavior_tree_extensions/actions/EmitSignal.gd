class_name EmitSignal
extends LeafTask

export var signal_name := ""


func execute() -> int:
#	print(signal_name)
	tree.host.emit_signal(signal_name)
	return self.Status.SUCCEEDED
