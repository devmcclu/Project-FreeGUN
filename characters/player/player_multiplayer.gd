extends Player

puppet var puppet_pos: Vector2 = Vector2()
puppet var puppet_velocity: Vector2 = Vector2()
puppet var puppet_rotation: float = 0

func make_gui() -> void:
	if is_network_master():
		$"Camera2D".make_current()
		$"CanvasLayer/GUI".visible = true


func get_input() -> void:
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
		
		rset("puppet_velocity", velocity)
		rset("puppet_pos", position)
	else:
		position = puppet_pos
		velocity = puppet_velocity
	#Normalize player movement input to make sure speed is constant
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	#Player looks at mouse
	if is_network_master():
		self.look_at(get_global_mouse_position())
		
		rset("puppet_rotation", rotation)
	else:
		self.rotation = puppet_rotation
		puppet_pos = position # To avoid jitter


func set_player_name(new_name) -> void:
	get_node("CanvasLayer/Label").set_text(new_name)