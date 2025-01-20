extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	SignalBus.add_point.connect(self._on_add_point)
	
func _physics_process(delta):
	global_position.x = get_global_mouse_position().x
	
func _on_add_point():
	animated_sprite.play("eat")


func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("idle")
