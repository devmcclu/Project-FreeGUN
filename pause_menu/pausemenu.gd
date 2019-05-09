extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var new_pause_state: bool = not get_tree().paused
		get_tree().paused = not get_tree().paused
		visible = new_pause_state
