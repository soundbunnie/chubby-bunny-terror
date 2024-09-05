extends CharacterBody2D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	
func _physics_process(delta):
	global_position.x = get_global_mouse_position().x
