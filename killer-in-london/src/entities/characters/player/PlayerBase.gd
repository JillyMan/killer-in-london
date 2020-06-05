class_name PlayerBase
extends KinematicBody2D

export var speed: float = 100.0
export var dash_speed : float = 350.0
export var dash_time_sec : float = 0.25

var current_dir : Vector2
var is_move : bool = false

func has_dir() -> bool:
	return is_move

# get_move_dir
func get_current_dir() -> Vector2:
	return current_dir

func update_move_dir():
	current_dir = Vector2.ZERO
	if Input.is_action_pressed("player_move_up"):
		current_dir.y = -1
	if Input.is_action_pressed("player_move_down"):
		current_dir.y = 1
	if Input.is_action_pressed("player_move_left"):
		current_dir.x = -1
	if Input.is_action_pressed("player_move_right"):
		current_dir.x = 1

	is_move = current_dir != Vector2.ZERO
