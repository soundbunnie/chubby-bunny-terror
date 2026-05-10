extends AnimatedSprite2D

@export var starting_point:Node2D
@export var target_point:Node2D
var t = 0.0
var n = 1

func _physics_process(_delta):
	if starting_point && target_point:
		t += _delta * n
		$".".position = starting_point.position.lerp(target_point.position, t)

func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player"):
			queue_free()
			SignalBus.add_point.emit(1)
		elif body.is_in_group("Floor"):
			queue_free()
			SignalBus.remove_point.emit(1)
