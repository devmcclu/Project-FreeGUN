#extends RigidBody2D
extends "res://characters/actor.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
"""
var health = 100
var gun_stats = [0, 500, 34]
var gun_ammo = [1, 0, 0]
"""

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	if self.health <= 0:
#		self.queue_free()

func _on_ShootTimer_timeout():
	self.shoot()
#	print("fire")
#	var new_bullet = load("res://bullet/bullet.tscn").instance()
#	$"../".add_child(new_bullet)
#	new_bullet.position = $"bullet_spawn".global_position
#	new_bullet.rotation = self.rotation
#	new_bullet.linear_velocity = Vector2(cos(self.rotation)*gun_stats[1], sin(self.rotation)*gun_stats[1])
#	new_bullet.parent = self
#	if gun_stats[0] > 0:
#		self.gun_ammo[gun_stats[0]] -= 1
#		print(gun_ammo[gun_stats[0]])
#		print("one less")
#	print(new_bullet.parent)

#func health_check():
#	if self.health <= 0:
#		self.queue_free()
