extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(.62,.37,.95))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
