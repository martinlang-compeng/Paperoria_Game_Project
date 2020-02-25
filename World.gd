extends Node

var collision_pos = []
var cpos
var label_value = 0

func _process(delta):
	cpos = $TileMap.world_to_map($Adventurer.position)
	
func _on_Adventurer_collided(collision):
	# KinematicCollision2D object emitted by character
	if collision.collider is TileMap:
		var tile_pos = collision.collider.world_to_map($Adventurer.position)
		tile_pos -= collision.normal  # Colliding tile
		var tile_id= collision.collider.get_cellv(tile_pos)
		var tile_title = collision.collider.tile_set.tile_get_name(tile_id)

		# When player encounters spikes, cause player damage
		if tile_title == "Spikes":
			$Adventurer.damage(10)
			$CanvasLayer/Interface/HeathBar._on_Adventurer_health_updated($Adventurer.health)
		
		if $Adventurer/Sprite.flip_h:
			if tile_pos[1] == cpos[1] and Input.is_key_pressed(KEY_E) and tile_title != "Spikes" and tile_id != -1:
				$TileMap.set_cellv(tile_pos, -1)
				label_value += 1
				print("hi")
				$CanvasLayer/Interface/blockCounter/Label.text = str(round(label_value))
		else:
			if tile_pos[1] == cpos[1] and Input.is_key_pressed(KEY_E) and tile_title != "Spikes" and tile_id != -1:
				$TileMap.set_cellv(tile_pos, -1)
				label_value += 1
				$CanvasLayer/Interface/blockCounter/Label.text = str(round(label_value))
	pass # Replace with function body.
