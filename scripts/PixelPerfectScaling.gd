# original code by CowThing: https://github.com/godotengine/godot/issues/6506
# port to Godot 3 and bugfixes by atomius.

# usage:
# set this script as AutoLoad (Singleton enabled)
#
# in the project settings:
# [display]
# set 'window/size/width' and 'window/size/height' to your desired render resolution.
# set 'window/size/test_width' and 'window/size/test_height' to the initial window size.
# set 'window/stretch/mode' to "viewport"
#
# [rendering]
# set 'quality/2d/use_pixel_snap' to true.


extends Node

onready var root = get_tree().root
onready var base_size = root.get_visible_rect().size


func _ready() -> void:
	get_tree().connect("screen_resized", self, "_on_screen_resized")
	
	root.set_attach_to_screen_rect(root.get_visible_rect())
	_on_screen_resized()


func _on_screen_resized() -> void:
	var new_window_size = OS.window_size
	
	var scale_w = max(int(new_window_size.x / base_size.x), 1)
	var scale_h = max(int(new_window_size.y / base_size.y), 1)
	var scale = min(scale_w, scale_h)
	
	var diff = new_window_size - (base_size * scale)
	var diffhalf = (diff * 0.5).floor()
	
	root.set_attach_to_screen_rect(Rect2(diffhalf, base_size * scale))
	
	# Black bars to prevent flickering:
	var odd_offset = Vector2(int(new_window_size.x) % 2, int(new_window_size.y) % 2)
	
	VisualServer.black_bars_set_margins(
		max(diffhalf.x, 0), # prevent negative values, they make the black bars go in the wrong direction.
		max(diffhalf.y, 0),
		max(diffhalf.x, 0) + odd_offset.x,
		max(diffhalf.y, 0) + odd_offset.y
	)
