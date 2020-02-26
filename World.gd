# -------------------------------------------------------
# Module Name: World.gd
# Author: Martin Lang
# Date of Creation: February 23, 2020
# -------------------------------------------------------
extends Node

var cpos
var label_value = 0

# Collect the character position relative to the game world
func _process(delta):
	cpos = $TileMap.world_to_map($Adventurer.position)

# Detects collisions between the Tilemap and the player
func _on_Adventurer_collided(collision):
	# KinematicCollision2D object emitted by character
	# Acquire position, id and name of collided tile
	if collision.collider is TileMap:
		var tile_pos = collision.collider.world_to_map($Adventurer.position)
		tile_pos -= collision.normal  # Colliding tile
		var tile_id= collision.collider.get_cellv(tile_pos)
		var tile_title = collision.collider.tile_set.tile_get_name(tile_id)

		# When player encounters spikes, cause player damage
		if tile_title == "Spikes":
			$Adventurer.damage(10)
			$CanvasLayer/Interface/HeathBar._on_Adventurer_health_updated($Adventurer.health)

# Allows block placement by player when correct action key is pressed
func _on_Adventurer_blockplace():
	# Check if player has blocks available
	if label_value > 0:
		# Place block according to direction player is facing
		# Also check if tilespace is empty
		if $Adventurer/Sprite.flip_h:
			cpos.x -= 1
			var tile_id = $TileMap.get_cellv(cpos)
			if tile_id == -1:
				$TileMap.set_cellv(cpos, 1)
				label_value -= 1
				$CanvasLayer/Interface/blockCounter/Label.text = str(round(label_value))
		else:
			cpos.x += 1
			var tile_id = $TileMap.get_cellv(cpos)
			if tile_id == -1:
				$TileMap.set_cellv(cpos, 1)
				label_value -= 1
				$CanvasLayer/Interface/blockCounter/Label.text = str(round(label_value))

# Allows block destruction by player when correct action key is pressed
func _on_Adventurer_blockdestroy():
	# Destroy blocks according to direction player is facing
	# check if tilespace is not empty or is a "Spike" tike
	if $Adventurer/Sprite.flip_h:
		cpos.x -= 1
		var tile_id = $TileMap.get_cellv(cpos)
		if tile_id != -1 and tile_id != 3:
			$TileMap.set_cellv(cpos, -1)
			label_value += 1
			$CanvasLayer/Interface/blockCounter/Label.text = str(round(label_value))
	else:
		cpos.x += 1
		var tile_id = $TileMap.get_cellv(cpos)
		if tile_id != -1 and tile_id != 3:
			$TileMap.set_cellv(cpos, -1)
			label_value += 1
			$CanvasLayer/Interface/blockCounter/Label.text = str(round(label_value))

# Allows for respawning of the player, when they die
func _on_Adventurer_kill():
	$Adventurer.position = $RespawnPoint.position
	$CanvasLayer/Interface/HeathBar._on_Adventurer_health_updated($Adventurer.max_health)
	pass # Replace with function body.
