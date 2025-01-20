extends Node2D

@onready var spawnTimer = $CarrotSpawnTimer
@onready var scoreLabel = $ScoreLabel
@onready var speedLabel = $SpeedLabel

@export var spawnInterval = 0.5

var carrotScene = load("res://carrot.tscn")

var score = 0

func _ready():
	spawnTimer.timeout.connect(_on_timer_timeout)
	SignalBus.add_point.connect(_on_add_point)
	update_speed_label()
	update_timer(0)
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

func _on_add_point(to_add):
	score += to_add
	if score % 10 == 0:
		update_timer(0.02)
		update_speed_label()
	update_score_label()
	
func update_score_label():
	scoreLabel.text = "Score: " + str(score)
	
func update_speed_label():
	speedLabel.text = "Speed: " + str(spawnInterval)
	
func update_timer(toAdd):
	update_speed_label()
	spawnInterval = spawnInterval - toAdd
	spawnTimer.wait_time = spawnInterval
