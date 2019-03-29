extends HBoxContainer

onready var player = $"../../../../../Gun"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_Gun_gun_changed():
	print("you changed bro")
	print(player)
	$"Counter/Panel/Amount".text = str(player.current_gun)