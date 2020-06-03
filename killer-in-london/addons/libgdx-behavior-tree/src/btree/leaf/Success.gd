class_name Success, "res://addons/libgdx-behavior-tree/assets/icons/succeeder_icon.png"
extends LeafTask


func execute() -> int:
	return self.Status.SUCCEEDED
