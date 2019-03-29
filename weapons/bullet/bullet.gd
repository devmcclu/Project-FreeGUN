extends RigidBody2D

onready var parent = self.get_parent()

func _ready():
	set_as_toplevel(true)

#Check the collision of the bullet with objects
func _on_bullet_body_entered(body):
	#Find the collision layer on contact
	match body.collision_layer:
		#Player/enemy collision layer
		1:
			if self.parent != body:
#				body.health -= parent.gun_stats[2]
#				body.health_check()
				body.get_node("Health").health_check(parent.damage)
				print(body.get_node("Health").health)
				self.queue_free()
		#Wall collision layer
		2:
			self.queue_free()
			print("nice wall")

#Delete bullet after timer runs out
func _on_Timer_timeout():
	self.queue_free()