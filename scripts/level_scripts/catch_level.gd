extends Node2D

# @export variables
@export var spawn_interval:float = 0.3
@export var points_to_progress:int = 10

# reference variables
var carrot_scene = load("res://carrot.tscn")

# private variables
var paused:bool = false
var score:int = 0

# @onready variables
@onready var spawn_timer = $CarrotSpawnTimer
@onready var score_label = $UI/ScoreLabel
@onready var pause_screen = $UI/PauseScreen

func _ready():
	# connecting signals
	spawn_timer.timeout.connect(_on_timer_timeout)
	SignalBus.add_point.connect(_on_point_added)
	SignalBus.remove_point.connect(_on_point_removed)
	SignalBus.pause_game.connect(_on_game_paused)
	SignalBus.unpause_game.connect(_on_game_unpaused)
	
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()
	
func _notification(what):
	match what:
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			SignalBus.pause_game.emit()
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			SignalBus.unpause_game.emit()
			
func _on_game_paused():
	SignalBus.pause_music.emit()
	get_tree().paused = true
	paused = true
	
func _on_game_unpaused():
	if !pause_screen.visible:
		print("pause screen not visible")
		SignalBus.unpause_music.emit()
		get_tree().paused = false
		paused = false
		
func _on_timer_timeout():
	spawn_carrot()

func _on_point_added(to_add):
	score += to_add
	if score % points_to_progress == 0:
		pass
	update_score_label()
	
func _on_point_removed(to_remove):
	if score > 0:
		score -= to_remove
		if score % points_to_progress == 0:
			pass
	update_score_label()

func spawn_carrot():
	var screen_size = get_viewport().get_visible_rect().size
	var rand = RandomNumberGenerator.new()
	# Spawn carrot at random position along x axis
	var carrot = carrot_scene.instantiate()
	rand.randomize()
	var x = rand.randf_range(0, screen_size.x)
	carrot.position.x = x
	add_child(carrot)
	
func update_score_label():
	score_label.text = "Score: " + str(score)
	
