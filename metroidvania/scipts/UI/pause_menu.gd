extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_button_pressed() -> void:
	GameManager.continue_game()
	queue_free()


func _on_main_menu_button_pressed() -> void:
	GameManager.main_menu()
	queue_free()
