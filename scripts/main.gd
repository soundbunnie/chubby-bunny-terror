extends Node2D

@onready var spawnTimer = $CarrotSpawnTimer
@onready var scoreLabel = $UI/ScoreLabel
@onready var pauseScreen = $UI/PauseScreen

@export var spawnInterval:float = 0.3
@export var points_to_progress:int = 10

var paused:bool = false

var carrotScene = load("res://carrot.tscn")

var score:int = 0

func _ready():
	spawnTimer.timeout.connect(_on_timer_timeout)
	SignalBus.add_point.connect(_on_add_point)
	SignalBus.remove_point.connect(_on_remove_point)
	SignalBus.pause_game.connect(pause_main)
	SignalBus.unpause_game.connect(unpause_main)
	spawnTimer.wait_time = spawnInterval
	spawnTimer.start()
	
func _notification(what):
	match what:
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			SignalBus.pause_game.emit()
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			SignalBus.unpause_game.emit()
			
func pause_main():
	SignalBus.pause_music.emit()
	get_tree().paused = true
	paused = true
	
func unpause_main():
	if !pauseScreen.visible:
		print("pause screen not visible")
		SignalBus.unpause_music.emit()
		get_tree().paused = false
		paused = false

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
		pass
	update_score_label()
	
func _on_remove_point(to_remove):
	if score > 0:
		score -= to_remove
		if score % points_to_progress == 0:
			pass
	update_score_label()
	
func update_score_label():
	scoreLabel.text = "Score: " + str(score)
	
