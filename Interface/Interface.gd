# -------------------------------------------------------
# Module Name: Startmenu.gd
# Author: Martin Lang
# Date of Creation: February 23, 2020
# -------------------------------------------------------
extends Control

# Return to start menu when quit button is pressed
func _on_Quit_pressed():
	get_tree().change_scene("res://Start Menu/StartMenu.tscn")
