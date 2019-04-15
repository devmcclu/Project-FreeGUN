extends Node2D

const Bullet = preload("res://weapons/bullet/bullet.tscn")

signal gun_changed
signal ammo_changed

var current_gun: int = 0
var bullet_speed: int = 500
var damage: int = 34

func _ready() -> void:
	make_gui()


func _process(delta: float) -> void:
	check_shoot()
	change_gun()


func make_gui() -> void:
	emit_signal("gun_changed")
	emit_signal("ammo_changed")


sync func _shoot() -> void:
	if $"Inventory".gun_ammo[current_gun] > 0:
		print("fire")
		#Bullet scene is loading into game
		var new_bullet = Bullet.instance()
		self.add_child(new_bullet)
		#Bullet position and rotation is set to the spawn point and rotation on the player
		new_bullet.position = $"BulletSpawn".global_position
		new_bullet.rotation = get_parent().rotation
		#Velocity of the bullet is set to the speed of the weapon's bullets
		new_bullet.linear_velocity = Vector2(cos(get_parent().rotation)*bullet_speed, sin(get_parent().rotation)*bullet_speed)
		#Check to see if player still has ammo for all guns besides starting weapon
		if current_gun > 0:
			$"Inventory".gun_ammo[current_gun] -= 1
			print($"Inventory".gun_ammo[current_gun])
			emit_signal("ammo_changed")
			print("one less")
		print(new_bullet.parent)


func change_gun() -> void:
	#Switch player weapon when switch weapon key is pressed
	if Input.is_action_just_pressed("switch_weapon_1"):
		if $"Inventory".has_guns[0] == true:
			self.current_gun = 0
			self.bullet_speed = 500
			self.damage = 34
			#Send signal to GUI about gun change
			emit_signal("gun_changed")
			emit_signal("ammo_changed")
	if Input.is_action_just_pressed("switch_weapon_2"):
		if $"Inventory".has_guns[1] == true:
			self.current_gun = 1
			self.bullet_speed = 100
			self.damage = 100
			#Send signal to GUI about gun change
			emit_signal("gun_changed")
			emit_signal("ammo_changed")
	if Input.is_action_just_pressed("switch_weapon_3"):
		if $"Inventory".has_guns[2] == true:
			self.current_gun = 2
			self.bullet_speed = 1000
			self.damage = 50
			#Send signal to GUI about gun change
			emit_signal("gun_changed")
			emit_signal("ammo_changed")


func check_shoot() -> void:
	if is_network_master():
		if Input.is_action_just_pressed("fire_gun"):
			rpc('_shoot')


func _on_Area2D_area_entered(area: Area2D) -> void:
	self.current_gun = area.gun_number
	self.bullet_speed = area.bullet_speed
	self.damage = area.damage
	$Inventory.gun_ammo[self.current_gun] += area.gun_ammo_count
	$Inventory.has_guns[current_gun] = true
	emit_signal("gun_changed")
	emit_signal("ammo_changed")
	area.queue_free()
