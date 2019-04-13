extends KinematicBody2D

signal gun_changed
signal ammo_changed
signal health_changed

#Base player variables and stats
export (int) var speed = 200
var velocity = Vector2()
