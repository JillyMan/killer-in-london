class_name PlayerBase
extends KinematicBody2D

export var speed: float = 30.0
export (float, 0.0, 1.0) var friction : float = 0.1

export var dash_speed : float = 350.0
export var dash_time_sec : float = 0.25

var current_dir : Vector2

func set_trail(value : bool):
	pass

func get_move_dir() -> Vector2:
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

	current_dir = current_dir.normalized()
