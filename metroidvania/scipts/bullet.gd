extends AnimatedSprite2D

var bullet_impact_effect = preload("res://scenes/bullet/bullet_impact_effect.tscn")

var speed: int = 600
var direction: int
var damage_amount: int = 1

func _physics_process(delta: float) -> void:
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	move_local_x(direction * speed * delta)

func _on_timer_timeout() -> void:
	queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	print("Bullet hit something")


func _on_hitbox_body_entered(body: Node2D) -> void:
		print("Bullet body entered")
		bullet_impact()

func get_damage_amount() -> int:
	return damage_amount

func bullet_impact() -> void:
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()
