extends Node

# @export variables
@export var music_array: Array[Resource]

# private variables
var pause_music:String = "Theme of Miranda"
var current_song:String
var tabbed_out:bool
var paused_position:float = 0.0

# @onready variables
@onready var music_player = $MusicPlayer
@onready var stream = AudioStreamPlayer.new()

func _ready():
	# connect signals
	SignalBus.change_music.connect(_on_music_changed)
	SignalBus.change_volume.connect(_on_volume_changed)
	SignalBus.pause_music.connect(_on_music_paused)
	SignalBus.unpause_music.connect(_on_music_unpaused)
	
func _notification(what):
	match what:
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			tabbed_out = true
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			tabbed_out = false
	
func _on_music_changed(mus_name):
	for i in music_array.size():
		var song = music_array[i]
		var song_arr_name = song.resource_path.get_file().get_basename()
		if song_arr_name == mus_name:
			current_song = song_arr_name
			music_player.stream = song
			music_player.play(paused_position)
			paused_position = 0.0

func _on_volume_changed(num):
	music_player.volume_db = linear_to_db(num)

func _on_music_paused():
	print(tabbed_out)
	paused_position = music_player.get_playback_position()
	if tabbed_out:
		music_player.stop()
	elif !tabbed_out:
		play_pause_music()
	
func _on_music_unpaused():
	_on_music_changed(current_song)

func play_pause_music():
	for i in music_array.size():
		var song = music_array[i]
		var song_arr_name = song.resource_path.get_file().get_basename()
		if song_arr_name == pause_music:
			music_player.stream = song
			music_player.play(0.0)
