extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var mouse_pos:Vector2

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	process_mode = Node.PROCESS_MODE_INHERIT
	SignalBus.add_point.connect(eat_carrot.unbind(1))
	SignalBus.pause_player.connect(pause_player)
	SignalBus.unpause_player.connect(unpause_player)
	
func _unhandled_input(event):
	if(event is InputEventMouseMotion):
		global_position.x = get_viewport().get_mouse_position().x
	
func pause_player():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	mouse_pos = get_viewport().get_mouse_position()

func unpause_player():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	Input.warp_mouse(mouse_pos)
	
func eat_carrot():
	animated_sprite.play("eat")

func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("idle")
