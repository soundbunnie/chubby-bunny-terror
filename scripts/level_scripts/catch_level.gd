extends BaseLevel

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
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _on_timer_timeout():
	spawn_carrot()

func _on_point_added(to_add):
	score += to_add
	if score % points_to_progress == 0: # basically checks if score is a multiple of the number of points to progress
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
