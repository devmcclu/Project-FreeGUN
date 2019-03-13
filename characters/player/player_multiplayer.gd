extends "res://characters/player/player.gd"

slave var slave_pos = Vector2()
slave var slave_velocity = Vector2()
slave var slave_rotation = 0
slave var slave_health = 100

func make_gui():
	emit_signal("gun_changed")
	
	if is_network_master():
		$"Camera2D".make_current()
		$"CanvasLayer/GUI".visible = true

func get_input():
	#Create controlable Vector2 for player movement input
	velocity = Vector2()
	if is_network_master():
		#Change movement Vector2 variables on player input
		if Input.is_action_pressed('player_move_right'):
			velocity.x += 1
		if Input.is_action_pressed('player_move_left'):
			velocity.x -= 1
		if Input.is_action_pressed('player_move_down'):
			velocity.y += 1
		if Input.is_action_pressed('player_move_up'):
			velocity.y -= 1
		
		rset("slave_velocity", velocity)
		rset("slave_pos", position)
	else:
		position = slave_pos
		velocity = slave_velocity
	#Normalize player movement input to make sure speed is constant
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	#Player looks at mouse
	if is_network_master():
		self.look_at(get_global_mouse_position())
		
		rset("slave_rotation", rotation)
	else:
		self.rotation = slave_rotation
		slave_pos = position # To avoid jitter

sync func _shoot():
	if gun_ammo[gun_stats[0]] > 0:
		print("fire")
		#Bullet scene is loading into game
		var new_bullet = load("res://weapons/bullet/bullet.tscn").instance()
		self.add_child(new_bullet)
		#Bullet position and rotation is set to the spawn point and rotation on the player
		new_bullet.position = $"BulletSpawn".global_position
		new_bullet.rotation = self.rotation
		#Velocity of the bullet is set to the speed of the weapon's bullets
		new_bullet.linear_velocity = Vector2(cos(self.rotation)*gun_stats[1], sin(self.rotation)*gun_stats[1])
		#Check to see if player still has ammo for all guns besides starting weapon
		if gun_stats[0] > 0:
			self.gun_ammo[gun_stats[0]] -= 1
			print(gun_ammo[gun_stats[0]])
			emit_signal("ammo_changed")
			print("one less")
			print(new_bullet.parent)

func check_shoot():
	if is_network_master():
		if Input.is_action_just_pressed("fire_gun"):
			rpc('_shoot')

func set_player_name(new_name):
	get_node("CanvasLayer/Label").set_text(new_name)