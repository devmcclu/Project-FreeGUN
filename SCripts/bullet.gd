extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var parent

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_bullet_body_entered(body):
	match body.collision_layer:
		1:
			if self.parent != body:
				body.health -= parent.gun_stats[2]
				print(body.health)
				self.queue_free()
			pass
		2:
			self.queue_free()
			print("nice wall")
			pass

func _on_Timer_timeout():
	self.queue_free()