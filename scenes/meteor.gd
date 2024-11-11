extends Area2D

var speed: int
var direction_x: float
var rotation_speed: float

signal collision

func _ready() -> void:
	var rng: RandomNumberGenerator  = RandomNumberGenerator.new()
	
	# Random texture (meteor graphics)
	#var meteor_path: String = "res://graphics/Meteors/meteorBrown_big" + str(rng.randi_range(1, 4)) + ".png"
	#$Sprite2D.texture = load(meteor_path)
	
	# Random texture (meteor graphics)
	var meteor_type = rng.randi_range(0, 1)  # 0 for brown, 1 for grey
	var meteor_color = "brown" if meteor_type == 0 else "grey"
	var meteor_path: String = "res://graphics/Meteors/meteor" + meteor_color.capitalize() + "_big" + str(rng.randi_range(1, 4)) + ".png"
	$Sprite2D.texture = load(meteor_path)

	# Starting position
	var width = get_viewport().get_visible_rect().size[0] # Width of your device
	var random_x = rng.randi_range(0, width) # 0 - 1280
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)
	
	# Speed, rotation, and direction - assigning random values
	speed = rng.randi_range(200, 500)
	direction_x = rng.randf_range(-1, 1)
	rotation_speed = rng.randi_range(40, 100)
	
func _process(delta: float) -> void:
	position += Vector2(direction_x, 1.0) * speed * delta
	rotation_degrees += rotation_speed * delta

func _on_body_entered(_body: Node2D) -> void:
	collision.emit()


func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	queue_free()
