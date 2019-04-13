extends "res://characters/character.gd"

func _ready():
	make_gui()

func make_gui():
	#emit_signal("gun_changed")
	#emit_signal("health_changed")
	$"Camera2D".make_current()
	$"CanvasLayer/GUI".visible = true
	#fire_gun = Input.is_action_just_pressed("fire_gun")

func _process(delta):
	pass
	#Player fire variable
	#check_shoot()
	#PLayer switch weapon variables
#	var weapon_up = Input.is_action_pressed("weapon_up")
#	var weapon_down = Input.is_action_pressed("weapon_down")
#	var switch_weapon_1 = Input.is_action_just_pressed("switch_weapon_1")
#	var switch_weapon_2 = Input.is_action_just_pressed("switch_weapon_2")
#	var switch_weapon_3 = Input.is_action_just_pressed("switch_weapon_3")
	
	#Switch weapons with scroll wheel
#	if weapon_up:
#		print("up a weapon")
#	if weapon_down:
#		print("down a weapon")
	
#	#Switch player weapon when switch weapon key is pressed
#	if switch_weapon_1:
#		if has_guns[0] == true:
#			self.gun_stats = [0, 500, 34]
#			#Send signal to GUI about gun change
#			emit_signal("gun_changed")
#			emit_signal("ammo_changed")
#	if switch_weapon_2:
#		if has_guns[1] == true:
#			gun_stats = [1, 100, 100]
#			#Send signal to GUI about gun change
#			emit_signal("gun_changed")
#			emit_signal("ammo_changed")
#	if switch_weapon_3:
#		if has_guns[2] == true:
#			gun_stats = [2, 1000, 50]
#			#Send signal to GUI about gun change
#			emit_signal("gun_changed")
#			emit_signal("ammo_changed")

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
	move_and_slide(velocity)
	#Player looks at mouse
	self.look_at(get_global_mouse_position())

func _physics_process(delta):
	get_input()

#func check_shoot():
#	if Input.is_action_just_pressed("fire_gun"):
#		self._shoot()

#On gun pickup, change gun variables
func _on_Area2D_area_entered(area):
	#Player's gun stats are changed to reflect the gun
	self.gun_stats = [area.gun_number, area.bullet_speed, area.damage]
	#Player has the gun
	self.has_guns[area.gun_number] = true
	#Player aquires base ammo for the gun
	self.gun_ammo[area.gun_number] = area.gun_ammo_count
	emit_signal("gun_changed")
	emit_signal("ammo_changed")
	area.queue_free()