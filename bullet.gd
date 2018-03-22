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
	if body.is_in_group("bullet"):
		pass
	elif body.is_in_group("not_player"):
		self.queue_free()
	elif self.parent != body:
		body.health -= parent.damage
		print(body.health)
		self.queue_free()

func _on_Timer_timeout():
	self.queue_free()
