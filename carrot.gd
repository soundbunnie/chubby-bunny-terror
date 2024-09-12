extends CharacterBody2D

@export var fallSpeed = 200.0
var gravity = 200.0

func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_slide()
