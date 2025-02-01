extends CharacterBody2D

@export var speed: float = 1000

func _physics_process(delta):
	velocity = Vector2(0, speed)
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Player"):
			queue_free()
			SignalBus.add_point.emit(1)
		elif collider.is_in_group("Floor"):
			queue_free()
			SignalBus.remove_point.emit(1)
