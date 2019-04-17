extends HBoxContainer

var level_timer

func _ready() -> void:
	if get_node("/root/Main").has_node("LevelTimer"):
		level_timer = get_node("/root/Main/LevelTimer")


func _process(delta: float) -> void:
	if level_timer:
		$"Counter/Panel/Amount".text = str(level_timer.time_left)
