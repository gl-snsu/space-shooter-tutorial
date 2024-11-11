extends CanvasLayer

static var image = load('res://graphics/UI/playerLife2_orange.png')
var time_elapse: int = 0

func set_health(health: int) -> void:
	# remove all children
	for child in $LifeContainer/HBoxContainer.get_children():
		child.queue_free()
		
	for i in health:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$LifeContainer/HBoxContainer.add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP


func _on_score_timer_timeout() -> void:
	time_elapse += 1
	$ScoreContainer/Label.text = str(time_elapse)
	Global.score = time_elapse
	
