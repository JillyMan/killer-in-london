class_name CommitEnemyLastSeenPosition
extends LeafTask


func execute() -> int:
	var host = tree.host
	host.enemy_last_seen_position = host.enemy.global_position
	return self.Status.RUNNING
