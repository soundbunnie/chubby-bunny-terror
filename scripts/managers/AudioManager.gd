extends Node
@export var music_array: Array[Resource]

@onready var musicPlayer = $MusicPlayer
@onready var stream = AudioStreamPlayer.new()

var pauseMusic = "Theme of Miranda"

var tabbedOut = false

var currentSong

var pausedPosition = 0.0

func _ready():
	SignalBus.change_music.connect(play_music)
	SignalBus.change_volume.connect(change_volume)
	SignalBus.pause_game.connect(pause_music)
	SignalBus.unpause_game.connect(unpause_music)
	
func _notification(what):
	match what:
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			tabbedOut = true
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			tabbedOut = false
	
func play_music(mus_name):
	for i in music_array.size():
		var song = music_array[i]
		var name = song.resource_path.get_file().get_basename()
		if name == mus_name:
			currentSong = name
			musicPlayer.stream = song
			musicPlayer.play(pausedPosition)
			pausedPosition = 0.0

func play_pause_music():
	for i in music_array.size():
		var song = music_array[i]
		var name = song.resource_path.get_file().get_basename()
		if name == pauseMusic:
			musicPlayer.stream = song
			musicPlayer.play(0.0)

func change_volume(num):
	musicPlayer.volume_db = linear_to_db(num)

func pause_music():
	pausedPosition = musicPlayer.get_playback_position()
	if tabbedOut:
		musicPlayer.stop()
	elif !tabbedOut:
		play_pause_music()
	
func unpause_music():
	play_music(currentSong)
