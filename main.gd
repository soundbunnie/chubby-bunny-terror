extends Node2D

@onready var spawnTimer = $CarrotSpawnTimer
@export var spawnInterval = 1.0
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
	
func _on_timer_timeout():
	spawn_carrot()
	
func _ready():
	spawnTimer.timeout.connect(_on_timer_timeout)
	spawnTimer.wait_time = spawnInterval
	spawnTimer.start()
	
