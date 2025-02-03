extends CharacterBody2D

# @export variables
@export var speed: float = 1000

func _physics_process(_delta):
	velocity = Vector2(0, speed) # this applies velocity only along the y axis
	move_and_slide()
	# sort through collision to decide whether to add or remove a point
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Player"):
			queue_free()
			SignalBus.add_point.emit(1)
		elif collider.is_in_group("Floor"):
			queue_free()
			SignalBus.remove_point.emit(1)
