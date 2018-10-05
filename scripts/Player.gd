extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal change_gun
signal ammo_change

#Base player variables and stats
export (int) var speed = 200
var velocity = Vector2()
var health = 100
#Array to check if player has a gun
var has_guns = [true, false, false]
#Array to store current gun stats (gun number(gun_stats[0]), bullet speed(gun_stats[1]), damage(gun_stats[2]))
var gun_stats = [0, 500, 34]
#array to store gun ammunition ammount
var gun_ammo = [1, 0, 0]

slave var slave_velocity = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	emit_signal("change_gun")
	pass

func health_check():
	if self.health <= 0:
		self.queue_free()

func _process(delta):
	#Player fire variable
	health_check()
	var fire_gun = Input.is_action_just_pressed("fire_gun")
	
	#PLayer switch weapon variables
	var weapon_up = Input.is_action_pressed("weapon_up")
	var weapon_down = Input.is_action_pressed("weapon_down")
	var switch_weapon_1 = Input.is_action_just_pressed("switch_weapon_1")
	var switch_weapon_2 = Input.is_action_just_pressed("switch_weapon_2")
	var switch_weapon_3 = Input.is_action_just_pressed("switch_weapon_3")
	
	#Player Fires Weapon if player has enough ammo
	if fire_gun and gun_ammo[gun_stats[0]] > 0:
		print("fire")
		#Bullet scene is loading into game
		var new_bullet = load("res://bullet.tscn").instance()
		$"../".add_child(new_bullet)
		#Bullet position and rotation is set to the spawn point and rotation on the player
		new_bullet.position = $"bullet_spawn".global_position
		new_bullet.rotation = self.rotation
		#Velocity of the bullet is set to the speed of the weapon's bullets
		new_bullet.linear_velocity = Vector2(cos(self.rotation)*gun_stats[1], sin(self.rotation)*gun_stats[1])
		#The parent of the bullet is set to the player
		new_bullet.parent = self
		#Check to see if player still has ammo for all guns besides starting weapon
		if gun_stats[0] > 0:
			self.gun_ammo[gun_stats[0]] -= 1
			print(gun_ammo[gun_stats[0]])
			emit_signal("ammo_change")
			print("one less")
		print(new_bullet.parent)
	
	#Switch weapons with scroll wheel
	if weapon_up:
		print("up a weapon")
	if weapon_down:
		print("down a weapon")
	
	#Switch player weapon when switch weapon key is pressed
	if switch_weapon_1:
		if has_guns[0] == true:
			self.gun_stats = [0, 500, 34]
			#Send signal to GUI about gun change
			emit_signal("change_gun")
			emit_signal("ammo_change")
		else:
			pass
	if switch_weapon_2:
		if has_guns[1] == true:
			gun_stats = [1, 100, 100]
			#Send signal to GUI about gun change
			emit_signal("change_gun")
			emit_signal("ammo_change")
		else:
			pass
	if switch_weapon_3:
		if has_guns[2] == true:
			gun_stats = [2, 1000, 50]
			#Send signal to GUI about gun change
			emit_signal("change_gun")
			emit_signal("ammo_change")
		else:
			pass

func get_input():
	#Create controlable Vector2 for player movement input
	velocity = Vector2()
	if (is_network_master()):
		#Change movement Vector2 variables on player input
		if Input.is_action_pressed('player_move_right'):
			velocity.x += 1
		if Input.is_action_pressed('player_move_left'):
			velocity.x -= 1
		if Input.is_action_pressed('player_move_down'):
			velocity.y += 1
		if Input.is_action_pressed('player_move_up'):
			velocity.y -= 1
	else:
		velocity = slave_velocity
	#Normalize player movement input to make sure speed is constant
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	#Player looks at mouse
	self.look_at(get_global_mouse_position())

#On gun pickup, change gun variables
func _on_Area2D_area_entered(area):
	#Player's gun stats are changed to reflect the gun
	self.gun_stats = [area.gun_number, area.bullet_speed, area.damage]
	#Player has the gun
	self.has_guns[area.gun_number] = true
	#Player aquires base ammo for the gun
	self.gun_ammo[area.gun_number] = area.gun_ammo_count
	emit_signal("change_gun")
	emit_signal("ammo_change")
	area.queue_free()

func set_player_name(new_name):
	#get_node("label").set_text(new_name)
	pass