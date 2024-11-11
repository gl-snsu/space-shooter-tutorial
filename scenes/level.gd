extends Node2D

# 1. Load the scene
var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")

func _ready() -> void:
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

func _on_meteor_titmer_timeout() -> void:
	# 2. Create an instance
	var meteor = meteor_scene.instantiate()
	
	# 3. Attach the node to the scene tree
	$Meteors.add_child(meteor)

func _on_player_laser(player_pos: Vector2) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = player_pos
