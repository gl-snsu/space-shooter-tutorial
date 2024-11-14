extends Node2D

# 1. Load the scene
var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var health_power_up_scene: PackedScene = load("res://scenes/health_power_up.tscn")

var health: int = 3

func _ready() -> void:
	# set up health ui
	get_tree().call_group('ui_layer', 'set_health', health)
	
	# Stars
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for star in $Stars.get_children():
		# position
		var random_x = rng.randi_range(0, int(size.x))
		var random_y = rng.randi_range(0, int(size.y))
		star.position = Vector2(random_x, random_y)
		
		# scale
		var random_scale = rng.randf_range(1, 1.6)
		star.scale = Vector2(random_scale, random_scale)
		
		# animation speed
		star.speed_scale = rng.randf_range(0.6, 1.4)

# Time where the meteor should spawn
func _on_meteor_timer_timeout() -> void:
	# 2. Create an instance
	var meteor = meteor_scene.instantiate()
	
	# 3. Attach the node to the scene tree
	$Meteors.add_child(meteor)
	
	# connect the signal
	meteor.connect('collision', _on_meteor_collision)
	meteor.connect('laser_collision', _on_meteor_laser_collision)
	
# Time where the health power-up should spawn
func _on_health_power_up_timer_timeout() -> void:
	var health_power_up = health_power_up_scene.instantiate()
	$HealthPowerUp.add_child(health_power_up)
	health_power_up.connect('health_collision', _on_health_power_up_collision)
		
# meteor and player collide
func _on_meteor_collision() -> void:
	$Player.play_collision_sound()
	health -= 1
	get_tree().call_group('ui_layer', 'set_health', health)
	
	if health <= 0:
		# Create a timer to delay the game over screen
		var timer = Timer.new()
		timer.wait_time = 0.2  # Adjust this time for the delay duration in seconds
		timer.one_shot = true
		
		add_child(timer)
		timer.start()
		
		# Await the timer's timeout signal
		await timer.timeout
		
		# Change to the game over scene after the delay
		get_tree().change_scene_to_file('res://scenes/game_over_control.tscn')
		
# meteor and laser collide
func _on_meteor_laser_collision() -> void:
	$MeteorLaserCollisionSound.play()

# Position the laser to the center of the player
func _on_player_laser(player_pos: Vector2) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = player_pos
	
# player and health power up collide
func _on_health_power_up_collision() -> void:
	$Player.play_health_collision_sound()
	health += 1
	get_tree().call_group('ui_layer', 'set_health', health)
