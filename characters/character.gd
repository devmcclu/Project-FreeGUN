extends KinematicBody2D
class_name Character
"""
Base character class. Gives node base variables and signals
"""


#Base player variables and stats
export (int) var speed = 200
var velocity: Vector2 = Vector2()