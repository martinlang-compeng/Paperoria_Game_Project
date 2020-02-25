# StartMenu.gd
extends Control

# Change to main game, when start button is pressed
func _on_Start_pressed():
	get_tree().change_scene("res://World.tscn")

# Quit application when quit button is pressed
func _on_Quit_pressed():
	get_tree().quit()
