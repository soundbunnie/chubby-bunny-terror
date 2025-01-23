extends Node
@export var music_array: Array[Resource]

@onready var musicPlayer = $MusicPlayer
@onready var stream = AudioStreamPlayer.new()

var paused_position = 0.0

func _ready():
	SignalBus.change_music.connect(play_music)
	SignalBus.change_volume.connect(change_volume)
	
func play_music(mus_name):
	for i in music_array.size():
		var song = music_array[i]
		var name = song.resource_path.get_file().get_basename()
		if name == mus_name:
			musicPlayer.stream = song
			musicPlayer.play(paused_position)
			paused_position = 0.0

func change_volume(num):
	musicPlayer.volume_db = linear_to_db(num)
