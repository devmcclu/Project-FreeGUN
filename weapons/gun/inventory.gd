extends Node

#Array to check if player has a gun
var has_guns = [true, false, false]
#Array to store current gun stats (gun number(gun_stats[0]), bullet speed(gun_stats[1]), damage(gun_stats[2]))
#var gun_stats = [0, 500, 34]
#var current_gun = 0
#var bullet_speed = 500
#var damage = 34
#array to store gun ammunition ammount
var gun_ammo = [1, 0, 0]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass