extends Node

var add_score: bool = true

var player_scores: Dictionary = {}

func _ready() -> void:
	# Add initial player scores
	for p_id in gamestate.players.keys():
		self.player_scores[p_id] = 0

#func _process(delta) -> void:
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

remote func update_score() -> void:
	pass