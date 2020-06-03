tool
class_name IsObjectInSign
extends GuardDecorator

export var object_property_name := ""


func check_condition() -> bool:
	var host = tree.host
	var sign_ray_cast : RayCast2D = host.sign_ray_cast
	var object = host.get(object_property_name)
	
	sign_ray_cast.cast_to = object.global_position - sign_ray_cast.global_position
	
	return sign_ray_cast.get_collider() == object
