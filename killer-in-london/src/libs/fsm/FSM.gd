class_name FSM
extends Node

export var host_node_path : NodePath
export var init_state_node_path : NodePath

var cur_state setget , get_state
var prev_state 
var host setget , get_host

#var history : = []

func _ready():
	host = get_node(host_node_path)
	yield(owner, "ready")
	set_state(get_node(init_state_node_path))
	pass


func handle_input(input):
	cur_state.handle_input(input)
	pass


func handle_unhandled_input(input):
	cur_state.handle_unhandled_input(input)
	pass


func handle_process(delta):
	cur_state.tick(delta)
	pass


func handle_physic_process(delta):
	cur_state.fixed_tick(delta)
	pass


func set_state(new_state, check_if_can = true, payload = {}) -> void:
	if cur_state == new_state:
		return

	if cur_state != null:
		if check_if_can and not cur_state.can_exit(new_state):
			return
		cur_state.exit(payload)
	
	_add_to_history(cur_state)
	
	cur_state = new_state
	cur_state.enter(payload)
	
#	print(cur_state.name)
	pass


func back(payload = null):
	set_state(_get_last_from_history())
	pass


func aborted():
	cur_state = _get_last_from_history()
	pass


func get_state():
	return cur_state


func get_host():
	return host


func _add_to_history(variant):
	prev_state = variant
	pass


func _get_last_from_history():
	return prev_state

