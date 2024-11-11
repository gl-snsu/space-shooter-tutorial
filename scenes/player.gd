extends CharacterBody2D

@export var speed: int = 1000
var can_shoot: bool = true

signal laser(pos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(100, 500)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Movement of space ship
	var movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = movement_direction * speed # Instead of using position,use velocity
	move_and_slide()
	
	# Shooting laser
	var shoot_laser = Input.is_action_just_pressed("shoot")
	if (shoot_laser and can_shoot):
		laser.emit($LaserStartPos.global_position)
		can_shoot = false
		$LaserTimer.start()

func _on_laser_timer_timeout() -> void:
	can_shoot = true
