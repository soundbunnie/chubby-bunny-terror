extends CanvasLayer

@onready var quitButton = $PauseMenu/Quit

@onready var volumeSlider = $PauseMenu/VolumeSlider
@onready var volumeLabel = $PauseMenu/VolumeSlider/VolumeLabel
@onready var volumeInput = $"PauseMenu/VolumeSlider/VolumeInput"

@onready var LineEditRegEx := RegEx.new()

var paused:bool = false

var quitConfirm:bool = false

func _ready():
	LineEditRegEx.compile("^[0-9.]*$")
	volumeInput.placeholder_text = (str(volumeSlider.value))

func pause():
	if !paused:
		paused = true
		show()
		SignalBus.pause_game.emit()
	elif paused:
		paused = false
		quitConfirm = false
		quitButton.set_text("Quit")
		hide()
		SignalBus.unpause_game.emit()

func _on_resume_pressed():
	pause()

func _on_quit_pressed():
	if !quitConfirm:
		quitButton.set_text("Are you sure?")
		quitConfirm = true
	elif quitConfirm:
		get_tree().quit()

func _on_volume_input_text_submitted(new_text):
	volumeInput.release_focus()
	volumeInput.text = ""

func _on_volume_input_text_changed(new_text):
	var old_text = ""
	if LineEditRegEx.search(new_text) && int(new_text) <= 100:
		old_text = str(new_text)
		volumeSlider.value = int(new_text)
	else:
		volumeInput.text = old_text
		volumeInput.set_caret_column(volumeInput.text.length())

func _on_volume_slider_value_changed(value):
	SignalBus.change_volume.emit(value)
	volumeInput.placeholder_text = (str(volumeSlider.value))
