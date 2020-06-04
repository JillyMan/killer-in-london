extends Control

func _ready():
	pass # Replace with function body.

func _on_NewGameButton_pressed():
	print("new game")
	pass # Replace with function body.

func _on_ContinueGameButton_pressed():
	print("continue game")
	pass # Replace with function body.


func _on_LevelsButton_pressed():
	print("levels")
	pass # Replace with function body.


func _on_OptionButton_pressed():
	print("options")
	$MarginContainer/HBoxContainer/VBoxContainer/Buttons.visible = false
	#$OptionScript.visible = true
	pass # Replace with function body.


func _on_ExitButton_pressed():
	get_tree().quit()
	print("exit")
	pass # Replace with function body.
