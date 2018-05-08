extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var health = 3

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if self.health <= 0:
		self.queue_free()
	pass
