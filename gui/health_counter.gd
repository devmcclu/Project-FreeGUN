extends HBoxContainer

onready var player = $"../../../../../"


func _on_health_changed() -> void:
	$Counter/Panel/Amount.text = str(player.get_node("Health").health)