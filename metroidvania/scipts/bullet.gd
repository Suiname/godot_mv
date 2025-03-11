extends AnimatedSprite2D

var speed: int = 600
var direction: int

func _physics_process(delta: float) -> void:
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	move_local_x(direction * speed * delta)

func _on_timer_timeout() -> void:
	queue_free()
