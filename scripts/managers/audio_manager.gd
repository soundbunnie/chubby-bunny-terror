extends Node
# AudioManager should handle playing music and sound effects

# @export variables
@export var music_array: Array[Resource]

# private variables
var pause_song:String = "Theme of Miranda"
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
	SignalBus.pause_game.connect(_on_game_paused)
	SignalBus.unpause_game.connect(_on_game_unpaused)
	
func _on_game_paused():
	paused_position = music_player.get_playback_position()
	play_pause_music()
	
func _on_game_unpaused():
	change_music(current_song)
	
func _on_music_changed(mus_name):
	change_music(mus_name)
	
func change_music(mus_name):
	# sorts through all music in array to find mus_name then plays the song once it's found
	for i in music_array.size():
		var song = music_array[i]
		var song_arr_name = song.resource_path.get_file().get_basename()
		if song_arr_name == mus_name:
			current_song = song_arr_name
			music_player.stream = song # creates new audiostreamplayer and binds the found song to it
			# note: music_player will play what its stream is
			music_player.play(paused_position) # paused_position shouldn't change unless music is paused or resumed
			paused_position = 0.0

func _on_volume_changed(num):
	# linear_to_db conversion makes the new volume sound more like what you would think
	# if you want to experiment, replace linear_to_db(num) with num and change the volume slider
	music_player.volume_db = linear_to_db(num)

func pause_music():
	paused_position = music_player.get_playback_position() # sets the new paused position
	music_player.stop()

func play_pause_music():
	# sort through music_array and play pause menu song
	# pretty much the same function as change_music(), but i decided to separate these two due to pause position
	for i in music_array.size():
		var song = music_array[i]
		var song_arr_name = song.resource_path.get_file().get_basename()
		if song_arr_name == pause_song:
			music_player.stream = song
			music_player.play(0.0)
