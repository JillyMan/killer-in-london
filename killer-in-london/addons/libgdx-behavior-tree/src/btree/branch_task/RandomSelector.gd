class_name RandomSelector, "res://addons/libgdx-behavior-tree/assets/icons/random_selector_icon.png"
extends Selector


func start():
	.start()
	randomize()
	self.child_indexes_queue.shuffle()
