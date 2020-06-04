class_name ExternalMethodGuard
extends GuardDecorator


export var method_name := ""


func check_condition() -> bool:
	return tree.host.call(method_name)
