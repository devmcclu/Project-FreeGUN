extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#Parent player of the bullet will be set to this in player.gd
var parent

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

#Check the collision of the bullet with objects
func _on_bullet_body_entered(body):
	#Find the collision layer on contact
	match body.collision_layer:
		#Player/enemy collision layer
		1:
			if self.parent != body:
				body.health -= parent.gun_stats[2]
				body.health_check()
				print(body.health)
				self.queue_free()
		#Wall collision layer
		2:
			self.queue_free()
			print("nice wall")

#Delete bullet after timer runs out
func _on_Timer_timeout():
	self.queue_free()