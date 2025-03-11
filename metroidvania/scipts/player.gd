extends CharacterBody2D
const GRAVITY = 1000
@export var speed: int = 1000
@export var max_speed: int = 300
@export var slow_down_speed: int = 1700


@export var jump_speed: int = -300
@export var jump_horizontal_speed: int = 1000
@export var jump_max_speed: int = 300
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var bullet = preload("res://scenes/bullet/bullet.tscn")
@onready var muzzle: Marker2D = $Muzzle

enum State {
	IDLE,
	RUN,
	JUMP,
	SHOOT,
}

var current_state: State
var muzzle_position
func _ready():
	current_state = State.IDLE
	muzzle_position = muzzle.position

func _physics_process(delta: float) -> void:
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	player_muzzle_position()
	player_shooting(delta)

	move_and_slide()

	player_animations()

func player_falling(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func player_idle(_delta: float) -> void:
	if is_on_floor():
		current_state = State.IDLE

func player_run(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x += direction * speed * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
	else:
		velocity.x = move_toward(velocity.x, 0, slow_down_speed * delta)

	if direction != 0 and is_on_floor():
		current_state = State.RUN
		animated_sprite_2d.flip_h = direction < 0

func player_jump(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		current_state = State.JUMP

	if !is_on_floor() and current_state == State.JUMP:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x += direction * jump_horizontal_speed * delta
		velocity.x = clamp(velocity.x, -jump_max_speed, jump_max_speed)

func player_shooting(_delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0 and Input.is_action_just_pressed("shoot"):
		var bullet_instance: Node2D = bullet.instantiate() as Node2D
		bullet_instance.set("direction", direction)
		bullet_instance.set("flip_h", direction < 0)
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
		current_state = State.SHOOT

func player_muzzle_position():
	var direction = input_movement()
	if direction > 0:
		muzzle.position.x = muzzle_position.x
	elif direction <0:
		muzzle.position.x = -muzzle_position.x


func player_animations():
	if current_state == State.IDLE:
		animated_sprite_2d.play("idle")
	elif current_state == State.RUN and animated_sprite_2d.animation != "run_and_shoot":
		animated_sprite_2d.play("run")
	elif current_state == State.JUMP:
		animated_sprite_2d.play("jump")
	elif current_state == State.SHOOT:
		animated_sprite_2d.play("run_and_shoot")

func input_movement():
	var direction = Input.get_axis("move_left", "move_right")
	return direction


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print("Enemy Entered", body.damage_amount)
		HealthManager.decrease_health(body.damage_amount)
	
