extends HBoxContainer

onready var player = $"../../../../../Gun/"

func _on_Gun_ammo_changed() -> void:
	print("you changed bro")
	$"Counter/Panel/Amount".text = str(player.get_node("Inventory").gun_ammo[player.current_gun])