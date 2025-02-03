extends CharacterBody2D

# @export variables
@export var move_speed:float = 0.6

# private variables
var mouse_pos:Vector2

# @onready variables
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	process_mode = Node.PROCESS_MODE_INHERIT
	SignalBus.add_point.connect(eat_carrot.unbind(1))
	
func _unhandled_input(event):
	if(event is InputEventMouseMotion):
		global_position.x += event.relative.x * move_speed
	
func eat_carrot():
	animated_sprite.play("eat")

func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("idle")
