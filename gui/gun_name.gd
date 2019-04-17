extends HBoxContainer

onready var player = $"../../../../../Gun"

func _on_Gun_gun_changed() -> void:
	print("you changed bro")
	print(player)
	$"Counter/Panel/Amount".text = str(player.current_gun)