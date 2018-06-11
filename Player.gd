extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#Base player variables and stats
export (int) var speed = 200
var velocity = Vector2()
var health = 100
var bullet_speed = 500
var damage = 34
var player_speed = 5
var current_gun = 0
#Array to check if player has a gun
var has_guns = [true, false, false]
#array to store gun ammunition ammount
var gun_ammo = [1, 0, 0]


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	#Player fire variable
	var fire_gun = Input.is_action_just_pressed("fire_gun")
	
	#PLayer switch weapon variables
	var weapon_up = Input.is_action_pressed("weapon_up")
	var weapon_down = Input.is_action_pressed("weapon_down")
	var switch_weapon_1 = Input.is_action_just_pressed("switch_weapon_1")
	var switch_weapon_2 = Input.is_action_just_pressed("switch_weapon_2")
	var switch_weapon_3 = Input.is_action_just_pressed("switch_weapon_3")
	
	#Player Fires Weapon
	if fire_gun and gun_ammo[current_gun] > 0:
		print("fire")
		var newBullet = load("res://bullet.tscn").instance()
		$"../".add_child(newBullet)
		newBullet.position = $"bullet_spawn".global_position
		newBullet.rotation = self.rotation
		newBullet.linear_velocity = Vector2(cos(self.rotation)*bullet_speed, sin(self.rotation)*bullet_speed)
		newBullet.parent = self
		if current_gun > 0:
			self.gun_ammo[current_gun] -= 1
			print(gun_ammo[current_gun])
			print("one less")
		print(newBullet.parent)
	
	#Switch weapons with scroll wheel
	if weapon_up:
		print("up a weapon")
	if weapon_down:
		print("down a weapon")
	
	if switch_weapon_1:
		if has_guns[0] == true:
			self.bullet_speed = 500
			self.damage = 34
			self.current_gun = 0
		else:
			pass
	if switch_weapon_2:
		if has_guns[1] == true:
			self.bullet_speed = 100
			self.damage = 100
			self.current_gun = 1
		else:
			pass
	if switch_weapon_3:
		if has_guns[2] == true:
			self.bullet_speed = 1000
			self.damage = 50
			self.current_gun = 2
		else:
			pass

func get_input():
	#Create controlable Vector2 for player movement input
	velocity = Vector2()
	#Change movement Vector2 variables on player input
	if Input.is_action_pressed('player_move_right'):
		velocity.x += 1
	if Input.is_action_pressed('player_move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('player_move_down'):
		velocity.y += 1
	if Input.is_action_pressed('player_move_up'):
		velocity.y -= 1
	#Normalize player movement input to make sure speed is constant
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	#Player looks at mouse
	self.look_at(get_global_mouse_position())

#On gun pickup, change gun variables
func _on_Area2D_area_entered(area):
	#if area.is_in_group("gun"):
	self.bullet_speed = area.bullet_speed
	self.damage = area.damage
	self.has_guns[area.gun_number] = true
	self.gun_ammo[area.gun_number] = area.gun_ammo_count
	self.current_gun = area.gun_number
	area.queue_free()