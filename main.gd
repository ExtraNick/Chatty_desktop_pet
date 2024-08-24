extends Node

@onready var _Camera: Camera2D = $Camera2D
@export var player_size: Vector2i = Vector2i(48	, 48)

func _process(delta: float) -> void:
	_Camera.position = get_window().position
# Called when the node enters the scene tree for the first time.
