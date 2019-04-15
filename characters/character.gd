extends KinematicBody2D

class_name Character

signal gun_changed
signal ammo_changed
signal health_changed

#Base player variables and stats
export (int) var speed = 200
var velocity : Vector2 = Vector2()
