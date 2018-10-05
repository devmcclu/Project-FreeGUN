extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Default game port
const DEFAULT_PORT = 10567

# Max number of players
const MAX_PEERS = 12

# Name for my player
var player_name = "The Warrior"

# Names for remote players in id:name format
var players = {}

# Signals to let lobby GUI know what's going on
signal player_list_changed()
signal connection_failed()
signal connection_succeeded()
signal game_ended()
signal game_error(what)

# Callback from SceneTree
func _player_disconnected(id):
	if (get_tree().is_network_server()):
		if (has_node("/root/world")): # Game is in progress
			emit_signal("game_error", "Player " + players[id] + " disconnected")
			end_game()
		else: # Game is not in progress
			# If we are the server, send to the new dude all the already registered players
			unregister_player(id)
			for p_id in players:
				# Erase in the server
				rpc_id(p_id, "unregister_player", id)

# Callback from SceneTree, only for clients (not server)
func _connected_ok():
	# Registration of a client beings here, tell everyone that we are here
	rpc("register_player", get_tree().get_network_unique_id(), player_name)
	emit_signal("connection_succeeded")

# Callback from SceneTree, only for clients (not server)
func _server_disconnected():
	emit_signal("game_error", "Server disconnected")
	end_game()

# Callback from SceneTree, only for clients (not server)
func _connected_fail():
	get_tree().set_network_peer(null) # Remove peer
	emit_signal("connection_failed")

# Lobby management functions

remote func register_player(id, new_player_name):
	if (get_tree().is_network_server()):
		# If we are the server, let everyone know about the new player
		rpc_id(id, "register_player", 1, player_name) # Send myself to new dude
		for p_id in players: # Then, for each remote player
			rpc_id(id, "register_player", p_id, players[p_id]) # Send player to new dude
			rpc_id(p_id, "register_player", id, new_player_name) # Send new dude to player

	players[id] = new_player_name
	emit_signal("player_list_changed")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
