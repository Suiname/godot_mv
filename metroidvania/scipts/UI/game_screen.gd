extends CanvasLayer

@onready var collectible_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/CollectibleLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ItemManager.on_award_received.connect(on_collectible_award_received)

func on_collectible_award_received(amount: int) -> void:
	collectible_label.text = str(amount)


func _on_pause_texture_button_pressed() -> void:
	GameManager.pause_game()
