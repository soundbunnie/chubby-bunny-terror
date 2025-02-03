extends CanvasLayer

#private variables
var paused:bool = false
var quit_confirm:bool = false

# @onready variables
@onready var quit_button = $PauseMenu/Quit
@onready var volume_slider = $PauseMenu/VolumeSlider
@onready var volume_label = $PauseMenu/VolumeSlider/VolumeLabel
@onready var volume_input = $"PauseMenu/VolumeSlider/VolumeInput"
@onready var LineEditRegEx := RegEx.new()

func _ready():
	SignalBus.pause_game.connect(_on_game_paused)
	SignalBus.unpause_game.connect(_on_game_unpaused)
	LineEditRegEx.compile("^[0-9.]*$")
	volume_input.placeholder_text = (str(volume_slider.value))

func _on_game_paused():
	show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _on_game_unpaused():
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _on_resume_pressed():
	SignalBus.unpause_game.emit()

func _on_quit_pressed():
	if !quit_confirm:
		quit_button.set_text("Are you sure?")
		quit_confirm = true
	elif quit_confirm:
		get_tree().quit()

func _on_volume_input_text_submitted(_new_text):
	volume_input.release_focus()
	volume_input.text = ""

func _on_volume_input_text_changed(new_text):
	var old_text = ""
	if LineEditRegEx.search(new_text) && int(new_text) <= 100:
		old_text = str(new_text)
		volume_slider.value = int(new_text)
	else:
		volume_input.text = old_text
		volume_input.set_caret_column(volume_input.text.length())

func _on_volume_slider_value_changed(value):
	SignalBus.change_volume.emit(value)
	volume_input.placeholder_text = (str(volume_slider.value))
	
