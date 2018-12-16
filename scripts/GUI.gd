extends MarginContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var parent

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_player_change_gun():
	#When the player changes guns, the GunName counter reflects what gun the player has
	print("you changed bro")
	$"VBoxContainer/HBoxContainer/GunName/Counter/Panel/Amount".text = str($"../../".gun_stats[0])
	pass # replace with function body


func _on_player_ammo_change():
	#When the ammo changes, either when the weapon is changed or bullet shot, update ammo count
	print("you changed bro")
	$"VBoxContainer/HBoxContainer/AmmoCounter/Counter/Panel/Amount".text = str($"../../".gun_ammo[$"../../".gun_stats[0]])
	pass # replace with function body


func _on_player_health_change():
	print("dying")
	$"VBoxContainer/HBoxContainer/HealthCounter/Counter/Panel/Amount".text = str($"../../".health)
	pass # replace with function body
