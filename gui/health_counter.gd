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


func _on_Player_health_changed():
	$Counter/Panel/Amount.text = str(player.health)
	pass # replace with function body
