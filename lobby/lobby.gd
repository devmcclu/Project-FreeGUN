extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready() -> void:
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#Connect gamestate signals to lobby functions
	gamestate.connect("connection_failed", self, "_on_connection_failed")
	gamestate.connect("connection_succeeded", self, "_on_connection_success")
	gamestate.connect("player_list_changed", self, "refresh_lobby")
	gamestate.connect("game_ended", self, "_on_game_ended")
	gamestate.connect("game_error", self, "_on_game_error")


func _on_host_pressed() -> void:
	#Don't host if no name is entered
	if get_node("Connect/Name").text == "":
		get_node("Connect/ErrorLabel").text="Invalid name!"
		return

	get_node("Connect").hide()
	get_node("Players").show()
	get_node("Connect/ErrorLabel").text=""

	var player_name = get_node("Connect/Name").text
	gamestate.host_game(player_name)
	refresh_lobby()


func _on_join_pressed() -> void:
	#Don't join if no name is entered
	if get_node("Connect/Name").text == "":
		get_node("Connect/ErrorLabel").text="Invalid name!"
		return

	var ip = get_node("Connect/IP").text
	if not ip.is_valid_ip_address():
		get_node("Connect/ErrorLabel").text="Invalid IPv4 address!"
		return

	get_node("Connect/ErrorLabel").text=""
	get_node("Connect/Host").disabled=true
	get_node("Connect/Join").disabled=true

	var player_name = get_node("Connect/Name").text
	gamestate.join_game(ip, player_name)
	# refresh_lobby() gets called by the player_list_changed signal


func _on_connection_success() -> void:
	get_node("Connect").hide()
	get_node("Players").show()


func _on_connection_failed() -> void:
	get_node("Connect/Host").disabled=false
	get_node("Connect/Join").disabled=false
	get_node("Connect/ErrorLabel").set_text("Connection failed.")


func _on_game_ended() -> void:
	show()
	get_node("Connect").show()
	get_node("Players").hide()
	get_node("Connect/Host").disabled=false
	get_node("Connect/Join").disabled


func _on_game_error(errtxt: String) -> void:
	get_node("Error").dialog_text = errtxt
	get_node("Error").popup_centered_minsize()


func refresh_lobby() -> void:
	var players = gamestate.get_player_list()
	players.sort()
	get_node("Players/List").clear()
	get_node("Players/List").add_item(gamestate.get_player_name() + " (You)")
	for p in players:
		get_node("Players/List").add_item(p)

	get_node("Players/Start").disabled=not get_tree().is_network_server()


func _on_start_pressed() -> void:
	gamestate.begin_game()