# -------------------------------------------------------
# Module Name: Startmenu.gd
# Author: Martin Lang
# Date of Creation: February 23, 2020
# -------------------------------------------------------
extends Control
 
# Change to game scene when start button is pressed
func _on_Start_pressed():
	get_tree().change_scene("res://World.tscn")

# Quit application when quit button is pressed
func _on_Quit_pressed():
	get_tree().quit()
