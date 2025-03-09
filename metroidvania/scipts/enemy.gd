extends CharacterBody2D
const GRAVITY = 1000
const SPEED = 1500
@export var patrol_points : Node
@export var speed: int = 1500
@export var wait_time: int = 3
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

enum State {
	IDLE,
	RUN,
}
var current_state: State
var direction: Vector2 = Vector2.LEFT
var number_of_points: int
var point_positions: Array[Vector2]
var current_point: Vector2
var current_point_position: int
var can_walk: bool = false

func _ready() -> void:
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol points found")

	timer.wait_time = wait_time
			
	current_state = State.IDLE

func _physics_process(delta: float) -> void:
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_run(delta)

	move_and_slide()

	enemy_animations()

func enemy_gravity(delta: float) -> void:
	velocity.y += GRAVITY * delta

func enemy_idle(delta: float) -> void:
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		current_state = State.IDLE

func enemy_run(delta: float) -> void:
	if !can_walk:
		return
	if abs(position.x - current_point.x) > 0.5:
		velocity.x = direction.x * speed * delta
		current_state = State.RUN
	else:
		current_point_position += 1
	
		if current_point_position >= number_of_points:
			current_point_position = 0
		current_point = point_positions[current_point_position]

		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT

		can_walk = false
		timer.start()

	animated_sprite_2d.flip_h = direction.x < 0

func enemy_animations():
	if current_state == State.IDLE && !can_walk:
		animated_sprite_2d.play("idle")
	elif current_state == State.RUN && can_walk:
		animated_sprite_2d.play("run")

func _on_timer_timeout() -> void:
	can_walk = true
