extends State

onready var tween = $Tween


func enter(payload):
	host.damage_producer_shape.set_deferred("disabled", false)
	var target_position = payload.target_position
	var body = host.body
	var half_attack_time = host.attack_time * 0.5
	
	tween.interpolate_property(body, "position", Vector2.ZERO, target_position, half_attack_time, Tween.TRANS_CIRC)
	tween.start()
	yield($Tween, "tween_completed")
	tween.interpolate_property(body, "position", target_position, Vector2.ZERO, half_attack_time)
	tween.start()
	pass


func _on_Tween_tween_all_completed():
	host.damage_producer_shape.set_deferred("disabled", true)
	fsm.back()
	pass
