# -------------------------------------------------------
# Module Name: HealthBar.gd
# Author: Martin Lang
# Date of Creation: February 23, 2020
# -------------------------------------------------------
extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $Update_Tween

# Update health to max health value
func _on_max_health_updated(max_health):
	health_over.max_value = max_health
	health_under.max_value = max_health

# Update Adventurer health to current value
func _on_Adventurer_health_updated(health):
	health_over.value = health
	# Tween property allows for smooth transition between health values
	update_tween.interpolate_property(health_under,"value", health_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()
