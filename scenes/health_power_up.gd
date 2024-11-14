extends Area2D

var speed: int
var direction_x: float

signal health_collision

func _ready() -> void:
	var rng: RandomNumberGenerator  = RandomNumberGenerator.new()
	
	var health_power_up_path: String = "res://graphics/Power-ups/pill_red.png"
	$Sprite2D.texture = load(health_power_up_path)

	# Starting position
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width) # 0 - 1280
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)
	
	speed = rng.randi_range(200, 500)
	direction_x = rng.randf_range(-1, 1)

func _process(delta: float) -> void:
	position += Vector2(direction_x, 1.0) * speed * delta

func _on_body_entered(_body: Node2D) -> void:
	health_collision.emit()
	queue_free()
