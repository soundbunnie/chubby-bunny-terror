extends CharacterBody2D

# @export variables
@export var move_speed:float = 0.6 # this is what % of the mouse movement should be applied to the player

# private variables
var mouse_pos:Vector2

# @onready variables
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	process_mode = Node.PROCESS_MODE_INHERIT
	SignalBus.add_point.connect(eat_carrot.unbind(1)) # unbinds parameter otherwise needed for adding point
	
func _unhandled_input(event):
	if(event is InputEventMouseMotion):
		# increases or decreases the players position along the x axis
		# based on mouse movement
		# and then decreases it by move_speed
		global_position.x += event.relative.x * move_speed
	
func eat_carrot():
	animated_sprite.play("eat")

func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("idle")
