extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var health = 100
var gun_stats = [0, 500, 34]
var gun_ammo = [1, 0, 0]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if self.health <= 0:
		self.queue_free()
	pass


func _on_ShootTimer_timeout():
	print("fire")
	var newBullet = load("res://bullet.tscn").instance()
	$"../".add_child(newBullet)
	newBullet.position = $"bullet_spawn".global_position
	newBullet.rotation = self.rotation
	newBullet.linear_velocity = Vector2(cos(self.rotation)*gun_stats[1], sin(self.rotation)*gun_stats[1])
	newBullet.parent = self
	if gun_stats[0] > 0:
		self.gun_ammo[gun_stats[0]] -= 1
		print(gun_ammo[gun_stats[0]])
		print("one less")
	print(newBullet.parent)
	pass # replace with function body
