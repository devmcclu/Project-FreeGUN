extends Node

signal health_changed

var health: int = 100

func _ready() -> void:
	emit_signal("health_changed")


func health_check(change: int) -> void:
	health -= change
	emit_signal("health_changed")
	if self.health <= 0:
		self.get_parent().queue_free()