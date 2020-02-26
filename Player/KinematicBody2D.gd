extends KinematicBody2D

signal health_updated(health)
signal kill()
signal collided(collision)
signal blockplace()
signal blockdestroy()

const UP_DIR = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION_X= 50
const MAX_CHARACTER_SPEED = 200
const JUMP_HEIGHT = -500

var motion = Vector2()
export (float) var max_health = 100
onready var health = max_health setget _set_health
onready var invulnerability = $Invulnearability
onready var respawn = $RespawnTimer
	
func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	# Get all collisions between character and tiles
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			emit_signal("collided", collision)
	
	# Movement Controls of Character:
	#	'A' for moving to the left
	#	'D' for moving to the right
	#	'SPACE' for jumping
	if Input.is_key_pressed(KEY_D) and health != 0:
		motion.x = min(motion.x + ACCELERATION_X, MAX_CHARACTER_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_key_pressed(KEY_A) and health != 0:
		motion.x = max(motion.x - ACCELERATION_X, -MAX_CHARACTER_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	elif Input.is_key_pressed(KEY_E) and health != 0:
		emit_signal("blockdestroy")
		$Sprite.play("Attack")
	elif Input.is_key_pressed(KEY_Q) and health != 0:
		emit_signal("blockplace")
		$Sprite.play("Attack")
	elif health != 0:
		$Sprite.play("Idle")
		friction = true
	else:
		$Sprite.play("dead")
		motion.x = 0
		emit_signal("kill")
		_set_health(max_health)
		health = max_health


	
	
	if is_on_floor():
		if Input.is_key_pressed(KEY_SPACE) and health != 0:
			motion.y = JUMP_HEIGHT
		if friction == true:
			# Allow for friction to occur on floor
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
			if friction == true:
				# Allow for friction to occur in the air
				motion.x = lerp(motion.x, 0, 0.05)
	
	# Movement Action for Character
	motion = move_and_slide(motion, UP_DIR)
	pass

# Function to cause damage to character
func damage(amount):
	if invulnerability.is_stopped():
		invulnerability.start()
		_set_health(health - amount)
		
# Function to signal kill action of character
func kill():
	pass
	
# Sets the current health value of the player
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	#$HealthBar._on_health_updated(health)
	
	if health != prev_health:
		emit_signal("health_updated", health)
