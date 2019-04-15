extends Control

func _ready() -> void:
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _on_Singleplayer_pressed() -> void:
	get_tree().change_scene("res://levels/Main.tscn")


func _on_Multiplayer_pressed() -> void:
	get_tree().change_scene("res://lobby/lobby.tscn")
