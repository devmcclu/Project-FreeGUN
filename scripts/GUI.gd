extends MarginContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var parent

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	$"VBoxContainer/HBoxContainer2/Timer/Counter/Panel/Amount".text = str($"../../../../Timer".time_left)

func _on_player_gun_changed():
	#When the player changes guns, the GunName counter reflects what gun the player has
	print("you changed bro")
	$"VBoxContainer/HBoxContainer/GunName/Counter/Panel/Amount".text = str($"../../".gun_stats[0])


func _on_player_ammo_changed():
	#When the ammo changes, either when the weapon is changed or bullet shot, update ammo count
	print("you changed bro")
	$"VBoxContainer/HBoxContainer/AmmoCounter/Counter/Panel/Amount".text = str($"../../".gun_ammo[$"../../".gun_stats[0]])


func _on_player_health_changed():
	print("dying")
	$"VBoxContainer/HBoxContainer/HealthCounter/Counter/Panel/Amount".text = str($"../../".health)
