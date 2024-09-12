extends Node2D

func spawn_carrot():
	var carrotScene = load("res://carrot.tscn")
	var screenSize = get_viewport().get_visible_rect().size
	var rand = RandomNumberGenerator.new()
	# Spawn carrot at random position along x axis
	var carrot = carrotScene.instantiate()
	rand.randomize()
	var x = rand.randf_range(0, screenSize.x)
	carrot.position.x = x
	add_child(carrot)
	
func _ready():
	spawn_carrot()
