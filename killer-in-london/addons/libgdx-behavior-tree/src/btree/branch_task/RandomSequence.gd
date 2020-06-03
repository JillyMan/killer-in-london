class_name RandomSequence, "res://addons/libgdx-behavior-tree/assets/icons/random_sequence_icon.png"
extends Sequence


func start():
	.start()
	randomize()
	self.child_indexes_queue.shuffle()
