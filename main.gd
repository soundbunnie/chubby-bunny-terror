extends Node2D

@onready var spawnTimer = $CarrotSpawnTimer
@onready var scoreLabel = $UI/ScoreLabel
@onready var speedLabel = $UI/SpeedLabel

@export var spawnInterval = 0.5
@export var points_to_progress = 10

var speedMultiplierText = 1
var speedMultiplier = 0.02

var carrotScene = load("res://carrot.tscn")

var score = 0

func _ready():
	spawnTimer.timeout.connect(_on_timer_timeout)
	SignalBus.add_point.connect(_on_add_point)
	SignalBus.remove_point.connect(_on_remove_point)
	update_speed_label()
	update_timer(0, "adding")
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
	if score % points_to_progress == 0:
		#update_timer(speedMultiplier, "adding")
		#update_speed_label()
		pass
	update_score_label()
	
func _on_remove_point(to_remove):
	if score > 0:
		score -= to_remove
		if score % points_to_progress == 0:
			#update_timer(speedMultiplier, "removing")
			#update_speed_label()
			pass
	update_score_label()
	
func update_score_label():
	scoreLabel.text = "Score: " + str(score)
	
func update_speed_label():
	speedLabel.text = "Speed: " + str(speedMultiplierText)
	
func update_timer(time_to_change, modifier):
	if modifier == "adding":
		spawnInterval = spawnInterval + (spawnInterval * time_to_change)
		speedMultiplierText = speedMultiplierText + (spawnInterval * time_to_change)
	elif modifier == "removing":
		spawnInterval = spawnInterval - (spawnInterval * time_to_change)
		speedMultiplierText = speedMultiplierText - (spawnInterval * time_to_change)
		
	spawnInterval = snapped(spawnInterval, 0.01)
	speedMultiplierText = snapped(speedMultiplierText, 0.01)
	spawnTimer.wait_time = spawnInterval
	update_speed_label()
