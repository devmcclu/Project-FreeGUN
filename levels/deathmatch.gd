extends Node

var add_score: bool = true
var score_limit: int = 2

var player_scores: Dictionary = {}

func _ready() -> void:
	# Add initial player scores
	pass
#	for p_id in gamestate.players.keys():
#		self.player_scores[p_id] = 0
#	print(player_scores.values())

#func _process(delta) -> void:
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

sync func update_score(player_id: int) -> void:
	assert(player_id in player_scores)
	player_scores[player_id].score += 1
	print(player_scores.values())
	
func add_player(id, new_player_name):
	player_scores[id] = { name = new_player_name, score = 0 }
	print(player_scores.values())