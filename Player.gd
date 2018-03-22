extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var bullet_speed = 500
var damage = 1
var player_speed = 5
var current_gun = 1
#Array to store guns
var has_guns = [true, false, false]


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	#Player movement variables
	var move_up = Input.is_action_pressed("player_move_up")
	var move_down = Input.is_action_pressed("player_move_down")
	var move_left = Input.is_action_pressed("player_move_left")
	var move_right = Input.is_action_pressed("player_move_right")
	
	#Player fire variable
	var fire_gun = Input.is_action_just_pressed("fire_gun")
	
	#PLayer switch weapon variables
	var weapon_up = Input.is_action_just_pressed("weapon_up")
	var weapon_down = Input.is_action_just_pressed("weapon_down")
	var switch_weapon_1 = Input.is_action_just_pressed("switch_weapon_1")
	var switch_weapon_2 = Input.is_action_just_pressed("switch_weapon_2")
	var switch_weapon_3 = Input.is_action_just_pressed("switch_weapon_3")
	
	
	#Player looks at mouse
	self.look_at(get_global_mouse_position())
	
	#Player Fires Weapon
	if fire_gun:
		print("fire")
		var newBullet = load("res://bullet.tscn").instance()
		$"../".add_child(newBullet)
		newBullet.position = $"bullet_spawn".global_position
		newBullet.rotation = self.rotation
		newBullet.linear_velocity = Vector2(cos(self.rotation)*bullet_speed, sin(self.rotation)*bullet_speed)
		newBullet.parent = self
		print(newBullet.parent)
	
	#Switch weapons with scroll whell
	if weapon_up:
		print("up a weapon")
	if weapon_down:
		print("down a weapon")
	
	#Player movement
	if move_up:
		self.position.y -= player_speed
	if move_down:
		self.position.y += player_speed
	if move_left:
		self.position.x -= player_speed
	if move_right:
		self.position.x += player_speed
	
#	if self.has_guns[2] == true:
#		print("new gun pa")

func _on_Area2D_area_entered(area):
	if area.is_in_group("gun"):
		self.bullet_speed = area.bullet_speed
		self.damage = area.damage
		self.has_guns[area.gun_number] = true
		area.queue_free()
