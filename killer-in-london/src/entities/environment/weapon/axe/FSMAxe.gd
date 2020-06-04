class_name AxeFSM
extends FSM

onready var IdleState : State = get_node("Idle")
onready var ThrowingState : State = get_node("Throwing")
onready var ComebackState : State = get_node("Comeback")

func set_throwing_state(target: Vector2):
	set_state(ThrowingState, true, { 
		"target": target,
	})

func set_idle_state():
	set_state(IdleState)

func set_comback_state(owner : KinematicBody2D):
	set_state(ComebackState, true, { 
		"come_to": owner,
	})
