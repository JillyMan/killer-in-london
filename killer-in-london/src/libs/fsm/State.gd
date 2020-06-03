class_name State
extends Node

var fsm : FSM
var host 

func _ready():
	fsm = get_parent()
	yield(fsm, "ready")
	host = fsm.host
	pass

func handle_input(input):
	pass

func handle_unhandled_input(input):
	pass

func tick(delta):
	pass

func fixed_tick(delta):
	pass

func enter(payload):
	pass

func exit(payload):
	pass

func can_exit(next_state) -> bool:
	return true
