extends CharacterBody2D

# @export variables
#@export var speed: float = 1000
@export var starting_point:Node2D
@export var target_point:Node2D

var t = 0.0
var n = 1.4

func _physics_process(_delta):
	if starting_point && target_point:
		self.position = self.position.move_toward(target_point.position, _delta*40000)
		#t += _delta * n
		#$AnimatedSprite2D.position = starting_point.position.lerp(target_point.position, t)
	#velocity = Vector2(0, speed) # this applies velocity only along the y axis
	#move_and_slide()
	# sort through collision to decide whether to add or remove a point
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
		#if collider.is_in_group("Player"):
		#	queue_free()
		#	SignalBus.add_point.emit(1)
	#	elif collider.is_in_group("Floor"):
		#	queue_free()
		#	SignalBus.remove_point.emit(1)
