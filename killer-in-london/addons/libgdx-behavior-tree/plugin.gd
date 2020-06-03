tool
extends EditorPlugin

var bt = "BehaviorTree"
var task = "Task"
var leaf_task = "LeafTask"
var branch_task = "BranchTask"
var single_running_child_branch = "SingleRunningChildBranchTask"
var decorator = "Decorator"
var loop_decorator = "LoopDecorator"
var guard_decorator = "GuardDecorator"

var failure = "Failure"
var success = "Success"

var includer = "Includer"
var inverter = "Inverter"
var repeater = "Repeater"
var waiter = "Waiter"

var dynamic_guard_selector = "DynamicGuardSelector"
var parralel = "Parralel"
var selector = "Selector"
var random_selector = "RandomSelector"
var sequence = "Sequence"
var random_sequence = "RandomSequence"


func _enter_tree():
	pass


func _exit_tree():
	pass
