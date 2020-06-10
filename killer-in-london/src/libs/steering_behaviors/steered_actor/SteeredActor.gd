extends KinematicBody2D

export var max_velocity : float = 1.0
export var max_see_ahead : float = 1.0

export(float, 1.0, 1000.0) var mass = 1.0
export(float, 1.0, 1000.0) var slowing_radius = 1.0
export (float, 0.0, 1000.0) var destination_radius = 1.0
export var wander_force : float

onready var obstacle_checker : RayCast2D = $ObstacleChecker

var _wander_angle : float
var _velocity : Vector2 setget , get_velocity
var _steering : Vector2

var _path_to_follow : Array setget set_path_to_follow
var _current_path_index := 0


func _ready():
	randomize()

func _process(delta):
	_steering = Vector2.ZERO
	_apply_behavior()
	_steering = _steering.clamped(max_velocity) * (1.0 / mass)
	pass

func _physics_process(delta):
#	print(_steering)
	_apply_steering()


func _apply_behavior():
	pass


func _apply_steering():
	_velocity += _steering
	_velocity = _velocity.clamped(max_velocity)
	move_and_slide(_velocity)
#	_velocity = move_and_slide(_velocity)
	_velocity = _velocity.linear_interpolate(Vector2.ZERO, 0.1)
	pass


func set_path_to_follow(value):
	_path_to_follow = value
	_current_path_index = 1


func follow_path():
	if not _path_to_follow or _path_to_follow.size() == 1:
		return Vector2.ZERO
	 
	var current_target = _path_to_follow[_current_path_index]
	
	if global_position.distance_to(current_target) <= destination_radius:
		_current_path_index += 1
		
		if _current_path_index >= _path_to_follow.size():
			_current_path_index = _path_to_follow.size() - 1
		pass
	
	var is_last_point = _current_path_index == _path_to_follow.size() - 1
	
	return raw_seek(current_target) if not is_last_point else seek(current_target)


func is_achieve_end_of_path() -> bool:
	return _current_path_index == _path_to_follow.size() - 1


func flee(target : Vector2):
	var desired : = (global_position - target)
	return desired * max_velocity


func evade(steerable):
	var to_steerable : Vector2 = (steerable.global_position - global_position)
	var t = to_steerable.length() / max_velocity
	
	var future_position = steerable.global_position + steerable.get_velocity() * t

	return flee(future_position)


func pursuit(steerable):
	var target_future_position
	
	if _velocity.dot(steerable.get_velocity()) > 0:
		var to_steerable : Vector2 = (steerable.global_position - global_position)
		var t = to_steerable.length() / max_velocity
		
		target_future_position = steerable.global_position + steerable.get_velocity() * t
	else:
		target_future_position = steerable.global_position
		
	return seek(target_future_position)


func raw_seek(target : Vector2):
	var desired : = (target - global_position).normalized() * max_velocity
	return desired - _velocity


func seek(target : Vector2):
	var distance
	
	var desired : = (target - global_position)
	distance = desired.length()
	
	if distance <= slowing_radius:
		desired = desired.normalized() * (max_velocity * distance / slowing_radius)
	else:
		desired = desired.normalized() * max_velocity
	
	return desired - _velocity 


func wander():
	var angle_change = 30

	var circle_center = _velocity.normalized()
	var displacement = Vector2.DOWN * wander_force

	displacement = displacement.rotated(deg2rad(_wander_angle))

	_wander_angle += randf() * angle_change - angle_change * 0.5

	return circle_center + displacement


func collision_avoidance1():
	var t = max_see_ahead * (_velocity.length() / max_velocity)
	var ahead = _velocity.normalized() * max_see_ahead
	
	obstacle_checker.cast_to = ahead
	var collider = obstacle_checker.get_collider()
	
	if not collider:
		return Vector2.ZERO
	
	var collision_point = obstacle_checker.get_collision_point()
	return (ahead - collision_point).normalized() * -15000


func collision_avoidance():
	var t = max_see_ahead * (_velocity.length() / max_velocity)
	var ahead = _velocity.normalized() * t
	
	obstacle_checker.cast_to = ahead
	var collider = obstacle_checker.get_collider()
	
	if not collider:
		return Vector2.ZERO
	
	var collision_center = _get_collision_center(collider)

	ahead += global_position
	
#	return (ahead - collision_center).normalized() * 75
	return obstacle_checker.get_collision_normal() * 750


func _get_collision_center(collider):
	if collider is TileMap:
		var collision_point = obstacle_checker.get_collision_point()
		var half_cell_size = collider.cell_size / 2
		
		return collider.map_to_world(collider.world_to_map(collision_point)) + half_cell_size
	else:
		return collider.global_position


func modern_collision_avoidance():
	var t = max_see_ahead * (_velocity.length() / max_velocity)
	var ahead = _velocity.normalized() * t
	
	obstacle_checker.cast_to = ahead
	var collider = obstacle_checker.get_collider()
	
	if not collider:
		return Vector2.ZERO
	
	var w = obstacle_checker.get_collision_normal()
	return (_velocity.dot(w) * w)


func get_velocity():
	return _velocity
