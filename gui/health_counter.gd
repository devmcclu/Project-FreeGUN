extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var player = $"../../../../../"

func _on_health_changed():
	$Counter/Panel/Amount.text = str(player.get_node("Health").health)
	pass # replace with function body
