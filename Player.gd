extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var bullet_speed = 500


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var move_up = Input.is_action_pressed("player_move_up")
	var move_down = Input.is_action_pressed("player_move_down")
	var move_left = Input.is_action_pressed("player_move_left")
	var move_right = Input.is_action_pressed("player_move_right")
	
	var fire_gun = Input.is_action_just_pressed("fire_gun")
	
	self.look_at(get_global_mouse_position())
	
	if fire_gun:
		print("fire")
		var newBullet = load("res://bullet.tscn").instance()
		$"../".add_child(newBullet)
		newBullet.position = $"bullet_spawn".global_position
		newBullet.rotation = self.rotation
		newBullet.linear_velocity = Vector2(cos(self.rotation)*bullet_speed, sin(self.rotation)*bullet_speed)
		newBullet.parent = self
		print(newBullet.parent)
	
	if move_up:
		self.position.y -= 5
	if move_down:
		self.position.y += 5
	if move_left:
		self.position.x -= 5
	if move_right:
		self.position.x += 5
	pass