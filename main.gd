extends Node2D

@onready var spawnTimer = $CarrotSpawnTimer
@onready var scoreLabel = $ScoreLabel

@export var spawnInterval = 0.5

var carrotScene = load("res://carrot.tscn")

var score = 0

func _ready():
	spawnTimer.timeout.connect(_on_timer_timeout)
	SignalBus.add_point.connect(self._on_add_point)
	spawnTimer.wait_time = spawnInterval
	spawnTimer.start()

func spawn_carrot():
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

func _on_add_point():
	score += 1
	update_score_label()
	
func update_score_label():
	scoreLabel.text = "Score: " + str(score)
