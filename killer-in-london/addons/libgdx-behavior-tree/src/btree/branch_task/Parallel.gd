tool
class_name Parallel, "res://addons/libgdx-behavior-tree/assets/icons/parallel_icon.png"
extends BranchTask

export(int, "sequence_policy", "selector_policy") var policy_type setget set_policy_type
export(int, "resume_orchestrator", "join_orchestrator") var orchestrator_type setget set_orchestrator_type


var no_running_tasks : bool
#bool or null
var last_result
var current_child_idx

var orchestrator
var policy

func _ready():
	self.policy_type = policy_type
	self.orchestrator_type = orchestrator_type
	pass


func run():
	orchestrator.execute(self)


func on_child_succeeded(task):
	last_result = policy.on_child_succeeded(self)
	pass


func on_child_failed(task):
	last_result = policy.on_child_failed(self)
	pass


func on_child_running(task):
	no_running_tasks = false
	pass


func reset():
	.reset()
	no_running_tasks = false


func reset_all_children():
	for child in .get_children():
		child.reset()
	pass


func set_policy_type(value):
	policy_type = value
	
	if value == 0:
		policy = SequencePolicy.new()
	elif value == 1:
		policy = SelectorPolicy.new()
	else:
		push_error("Unexpected policy type " + value)


func set_orchestrator_type(value):
	orchestrator_type = value
	
	if value == 0:
		orchestrator = ResumeOrchestrator.new()
	elif value == 1:
		orchestrator = JoinOrchestrator.new()
	else:
		push_error("Unexpected orchestrator type " + value)


class SelectorPolicy:
	func on_child_succeeded(parallel : Parallel) -> bool:
		return true
	
	
	func on_child_failed(parallel : Parallel) -> bool:
		return false if parallel.no_running_tasks and parallel.current_child_idx == parallel.get_child_count() - 1 else null


class SequencePolicy:
	func on_child_succeeded(parallel : Parallel) -> bool:
		if parallel.orchestrator_type == 0: #Join type
			return true if parallel.no_running_tasks and parallel.get_children().back().current_status == parallel.Status.SUCCEEDED else null
		elif parallel.orchestrator_type == 1: # Resume type
			return true if parallel.no_running_tasks and parallel.current_child_idx == (parallel.get_child_count() - 1) else null
		return false
	
	
	func on_child_failed(parallel : Parallel) -> bool:
		return false


class JoinOrchestrator:
	func execute(parallel : Parallel):
		parallel.no_running_tasks = true
		parallel.last_result = null
		parallel.current_child_idx = 0
		
		for child in parallel.get_children():
			var child_status = child.current_status
			if child_status == parallel.Status.RUNNING:
				child.run()
			elif not child_status == parallel.Status.SUCCEEDED and not child_status == parallel.Status.FAILED:
				child.parent_task = parallel
				child.start()
				child.run()
			
			if not parallel.last_result == null:
				var from_idx = parallel.current_child_idx + 1 if parallel.no_running_tasks else 0
				parallel.cancel_running_children(from_idx)
				parallel.reset_all_children()
				if parallel.last_result == true:
					parallel.success()
				else:
					parallel.fail()
				return
			parallel.current_child_idx += 1
		parallel.running()
		pass


class ResumeOrchestrator:
	func execute(parallel : Parallel):
		parallel.no_running_tasks = true
		parallel.last_result = null
		parallel.current_child_idx = 0
		
		for child in parallel.get_children():
			if child.current_status == parallel.Status.RUNNING:
				child.run()
			else:
				child.parent_task = parallel
				child.start()
				child.run()
			
			if not parallel.last_result == null:
				var from_idx = parallel.current_child_idx + 1 if parallel.no_running_tasks else 0
				parallel.cancel_running_children(from_idx)
				if parallel.last_result == true:
					parallel.success()
				else:
					parallel.fail()
				return
			parallel.current_child_idx += 1
		parallel.running()
		pass
