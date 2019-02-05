extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var player = $"../../../../../"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Player_ammo_changed():
	#When the ammo changes, either when the weapon is changed or bullet shot, update ammo count
	print("you changed bro")
	$"Counter/Panel/Amount".text = str(player.gun_ammo[player.gun_stats[0]])
