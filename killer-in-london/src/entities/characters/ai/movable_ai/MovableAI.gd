extends KinematicBody2D

export var friction : = 0.1
export var max_speed : = 0.0
export var max_separation : = 0.0
export var separation_radius : = 0.0
export var slowing_radius : = 0.0
export var destination_radius : = 0.0
export(float, 1, 9999) var mass : = 1.0

var steering : = Vector2.ZERO
var velocity : = Vector2.ZERO
var path_to_follow setget set_path_to_follow
var current_movement_target
var wander_angle : = 0.0


func _ready():
	randomize()
	pass


func _physics_process(delta):
	if current_movement_target != null:
		if path_to_follow.size() == 0:
			steering += arrival()
		else:
			steering += seek()
		steering += separate()
		
	steering = steering / mass
	velocity = (velocity + steering).clamped(max_speed)
	velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	
	move_and_slide(velocity)
	pass


#func wander():
#	if obstackle_cheker.get_collider():
#		velocity *= -1
#
#	var circle_radius = 50
#	obstackle_cheker.cast_to = velocity.normalized() * circle_radius
#
#	var angle_change = 30
#
#	var circle_center = velocity.normalized()
#	var displacement = Vector2.DOWN * circle_radius
#
#
#	displacement = displacement.rotated(deg2rad(wander_angle))
#
#	wander_angle += randf() * angle_change - angle_change * 0.5
#
#	return circle_center + displacement


func separate():
	var force = Vector2.ZERO
	var neighbour_count = 0

	for follower in get_tree().get_nodes_in_group("followers"):
		var a = follower.global_position
		var b = global_position

		if follower != self and a.distance_to(b) <= separation_radius: 
			force.x += a.x - b.x
			force.y += a.y - b.y
			neighbour_count += 1

	if neighbour_count != 0:
		force.x /= float(neighbour_count)
		force.y /= float(neighbour_count)

		force *= -1

	force = force.normalized() * max_separation

	return force


func seek():
	var movement_direction = global_position.direction_to(current_movement_target)
	var desired_velocity = movement_direction * max_speed

	var force = desired_velocity - velocity
	return force


func arrival():
	var movement_direction = global_position.direction_to(current_movement_target)
	var distance = global_position.distance_to(current_movement_target)
	var desired_velocity

	if distance < slowing_radius:
		desired_velocity = movement_direction * max_speed * (distance / slowing_radius)
	else:
		desired_velocity = movement_direction * max_speed

	var steering = desired_velocity - velocity

	return steering


func set_path_to_follow(path):
	path_to_follow = path
	current_movement_target = _get_next_movement_point_from_path()
	current_movement_target = _get_next_movement_point_from_path()
	pass


func get_distance_to_current_movement_target():
	return global_position.distance_to(current_movement_target)


func _get_next_movement_point_from_path():
	if path_to_follow.size() > 0:
		current_movement_target = path_to_follow.pop_front()
	return current_movement_target
