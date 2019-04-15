extends Character

class_name Player

func _ready() -> void:
	make_gui()

func make_gui() -> void:
	$"Camera2D".make_current()
	$"CanvasLayer/GUI".visible = true

func _process(delta : float) -> void:
	pass

func get_input() -> void:
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

func _physics_process(delta : float) -> void:
	get_input()