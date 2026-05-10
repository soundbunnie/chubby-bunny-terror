extends BaseLevel

# @export variables
@export var spawn_interval:float = 0.3
@export var points_to_progress:int = 10
@export var lanes:Array[Node2D]
@export var floor:Node2D
@export var timer:Timer

# reference variables
var carrot_scene = load("res://carrot_catch.tscn")

# private variables
var paused:bool = false
var score:int = 0
var timer_started = false
var t = 0.0
var n = 1

# @onready variables
@onready var score_label = $UI/ScoreLabel
@onready var pause_screen = $UI/PauseScreen

func _ready():
	# connecting signals
	SignalBus.add_point.connect(_on_point_added)
	SignalBus.remove_point.connect(_on_point_removed)
	SignalBus.note_played.connect(spawn_carrot)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # locks cursor to screen and hides it
	
	for lane in lanes:
		lane.get_child(0).position.x = lane.position.x
		
func _physics_process(delta: float) -> void:
	if !timer_started:
		t += delta * n
		if t < 1:
			timer.start()
			print("Game: ", t)
			timer_started = true
	
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

func spawn_carrot(note, vel):
	# spawns note in related lane
	# if note value is 0, it will spawn in index 0 of array (first element in this case)
	# REMINDER: array starts at 0!! if you put the note value as 4, it will actually spawn in the fifth lane
	# velocity will be a flex variable, in this catch level, it could be spawning a different object, in schmup
	# level, could be spawning a different mob type
	# print(note)
	if note > lanes.size() - 1:
		print("Note out of range: ", note) # throws an error message if there isn't a track for the note
	else:
		var lane = lanes[note]
		var carrot = carrot_scene.instantiate()  # creates instance of carrot scene (basically a copy of the carrot)
		carrot.position.x = lane.position.x
		carrot.starting_point = lane
		carrot.target_point = lane.get_child(0)
		add_child(carrot) # this adds it to the actual scene tree
	
func update_score_label():
	score_label.text = "Score: " + str(score)

func _on_timer_timeout() -> void:
	print("starting song")
	SignalBus.change_music.emit("song_test")
