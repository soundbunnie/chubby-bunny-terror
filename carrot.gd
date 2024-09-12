extends CharacterBody2D

@export var fallSpeed = 1000.0

var gravity = Vector2(0, fallSpeed)

func _physics_process(delta):
	velocity += gravity * delta
	#velocity.y += fallSpeed
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Player"):
			print("Player hit")
			queue_free()
