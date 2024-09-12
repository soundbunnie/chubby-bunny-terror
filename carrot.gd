extends CharacterBody2D

@export var fallSpeed = 20.0

func _physics_process(delta):
	velocity.y += fallSpeed
	move_and_slide()
