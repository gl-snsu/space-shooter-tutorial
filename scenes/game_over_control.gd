extends Control

@export var level_scene: PackedScene

var time_elapse: int = 3
var can_start_again: bool = false

func _ready() -> void:
	$CenterContainer/VBoxContainer/Label2.text = $CenterContainer/VBoxContainer/Label2.text + str(Global.score)
	$MarginContainer/Label.visible = false

func _input(event: InputEvent) -> void:
	if can_start_again and event.is_action_pressed('shoot'):
		get_tree().change_scene_to_packed(level_scene)
	
func _on_timer_timeout() -> void:
	if time_elapse > 0:
		time_elapse -= 1
		$CenterContainer/VBoxContainer/MarginContainer/Label3.text = str(time_elapse)
	else:
		can_start_again = true
		$CenterContainer/VBoxContainer/MarginContainer/Label3.text = ""
		$MarginContainer/Label.visible = true
