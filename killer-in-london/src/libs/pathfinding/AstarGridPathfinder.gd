tool
class_name AstarGridPathfinder
extends TileMap

# The Tilemap node doesn't have clear bounds so we're defining the map's limits here.
export(Vector2) var map_size = Vector2(16, 16)
export var debug_mode : = false
export var allow_diagonal_connection : = false


# You can only create an AStar node from code, not from the Scene tab.
onready var astar_node = AStar.new()
# get_used_cells_by_id is a method from the TileMap node.
# Here the id 0 corresponds to the grey tile, the obstacles.
onready var obstacles = get_used_cells_by_id(0)
onready var _half_cell_size = cell_size / 2

func _ready():
	var walkable_cells_list = astar_add_walkable_cells(obstacles)
	
	if allow_diagonal_connection:
		astar_connect_walkable_cells_diagonal(walkable_cells_list)
	else:
		astar_connect_walkable_cells(walkable_cells_list)


func _process(delta):
	if debug_mode:
		update()


# Loops through all cells within the map's bounds and
# adds all points to the astar_node, except the obstacles.
func astar_add_walkable_cells(obstacle_list = []):
	var points_array = []
	for y in range(map_size.y):
		for x in range(map_size.x):
			var point = Vector2(x, y)
			if point in obstacle_list:
				continue

			points_array.append(point)
			# The AStar class references points with indices.
			# Using a function to calculate the index from a point's coordinates
			# ensures we always get the same index with the same input point.
			var point_index = calculate_point_index(point)
			# AStar works for both 2d and 3d, so we have to convert the point
			# coordinates from and to Vector3s.
			astar_node.add_point(point_index, Vector3(point.x, point.y, 0.0))
	return points_array


# Once you added all points to the AStar node, you've got to connect them.
# The points don't have to be on a grid: you can use this class
# to create walkable graphs however you'd like.
# It's a little harder to code at first, but works for 2d, 3d,
# orthogonal grids, hex grids, tower defense games...
func astar_connect_walkable_cells(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		# For every cell in the map, we check the one to the top, right.
		# left and bottom of it. If it's in the map and not an obstalce.
		# We connect the current point with it.
		var points_relative = PoolVector2Array([
			Vector2(point.x + 1, point.y),
			Vector2(point.x - 1, point.y),
			Vector2(point.x, point.y + 1),
			Vector2(point.x, point.y - 1)])
		for point_relative in points_relative:
			var point_relative_index = calculate_point_index(point_relative)
			if is_outside_map_bounds(point_relative):
				continue
			if not astar_node.has_point(point_relative_index):
				continue
			# Note the 3rd argument. It tells the astar_node that we want the
			# connection to be bilateral: from point A to B and B to A.
			# If you set this value to false, it becomes a one-way path.
			# As we loop through all points we can set it to false.
			astar_node.connect_points(point_index, point_relative_index, false)


# This is a variation of the method above.
# It connects cells horizontally, vertically AND diagonally.
func astar_connect_walkable_cells_diagonal(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		for local_y in range(3):
			for local_x in range(3):
				var point_relative = Vector2(point.x + local_x - 1, point.y + local_y - 1)
				var point_relative_index = calculate_point_index(point_relative)
				if point_relative == point or is_outside_map_bounds(point_relative):
					continue
				if not astar_node.has_point(point_relative_index):
					continue
				astar_node.connect_points(point_index, point_relative_index, true)


func calculate_point_index(point):
	return point.x + map_size.x * point.y


func is_outside_map_bounds(point):
	return point.x < 0 or point.y < 0 or point.x >= map_size.x or point.y >= map_size.y


func calculate_path(world_start, world_end):
	var path_world = []
	var map_start = world_to_map(world_start)
	var map_end = world_to_map(world_end)
	
	if not is_movement_point_reachable(map_start) or not is_movement_point_reachable(map_end):
		return path_world
	
	var path_start_position = calculate_point_index(map_start)
	var path_end_position = calculate_point_index(map_end)
	
	var point_path = astar_node.get_point_path(path_start_position, path_end_position)
	
	for point in point_path:
		var point_world = map_to_world(Vector2(point.x, point.y)) + _half_cell_size
		path_world.append(point_world)
	return path_world


func _draw():
	if not debug_mode:
		return 
	
	var pos = Vector2(
		position.x,
		position.y
	)
	
	var rect = Rect2(pos, map_size * cell_size)
	#var pos = global_position
	#draw_line(pos, pos + Vector2(map_size.x * 32, 0), Color.red)
	draw_rect(rect, Color(1, 0, 0, 0.3))
	
	pass


func is_movement_point_reachable(value):
	if value in obstacles:
		return false
	if is_outside_map_bounds(value):
		return false
	return true
	
