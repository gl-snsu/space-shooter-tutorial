extends Node2D

# 1. Load the scene
var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")

func _on_meteor_titmer_timeout() -> void:
	# 2. Create an instance
	var meteor = meteor_scene.instantiate()
	
	# 3. Attach the node to the scene tree
	$Meteors.add_child(meteor)

func _on_player_laser(player_pos: Vector2) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = player_pos
	print(player_pos)
