extends CharacterBody2D
const GRAVITY = 1000
const SPEED = 300
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

enum State {
	IDLE,
	RUN,
	JUMP,
}

var current_state: State

func _ready():
	current_state = State.IDLE

func _physics_process(delta: float) -> void:
	player_falling(delta)
	player_idle(delta)
	player_run(delta)

	move_and_slide()

	player_animations()

func player_falling(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func player_idle(delta: float) -> void:
	if is_on_floor():
		current_state = State.IDLE

func player_run(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction != 0:
		current_state = State.RUN
		animated_sprite_2d.flip_h = direction < 0

func player_animations():
	if current_state == State.IDLE:
		animated_sprite_2d.play("idle")
	elif current_state == State.RUN:
		animated_sprite_2d.play("run")
	elif current_state == State.JUMP:
		animated_sprite_2d.play("jump")
