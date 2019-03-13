extends Node

signal health_changed
slave var slave_health = 100

var health = 100

func _ready():
	if is_network_master():
		emit_signal("health_changed")

sync func health_check(change):
	if is_network_master():
		health -= change
		emit_signal("health_changed")
		rset("slave_health", health)
	else:
		health = slave_health
	if self.health <= 0:
		self.get_parent().queue_free()
