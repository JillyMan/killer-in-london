class_name Failure, "res://addons/libgdx-behavior-tree/assets/icons/failer_icon.png"
extends LeafTask


func execute() -> int:
	return self.Status.FAILED
