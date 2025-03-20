extends Node
const LEVEL_1 = preload("res://scenes/levels/level_1.tscn")
const PAUSE_MENU = preload("res://scenes/UI/pause_menu.tscn")
const MAIN_MENU = preload("res://scenes/UI/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(.62,.37,.95))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func start_game() -> void:
	if get_tree().paused:
		continue_game()
		return
	transition_to_scene(LEVEL_1.resource_path)

func transition_to_scene(scene_path: String) -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(scene_path)

func exit_game() -> void:
	get_tree().quit()

func pause_game() -> void:
	var pause_menu_instance = PAUSE_MENU.instantiate()
	get_tree().get_root().add_child(pause_menu_instance)
	get_tree().paused = true

func continue_game() -> void:
	get_tree().paused = false

func main_menu() -> void:
	var main_menu_instance = MAIN_MENU.instantiate()
	get_tree().get_root().add_child(main_menu_instance)
	
