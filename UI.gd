extends Control

@onready var pauseScreen = $PauseScreen

var paused = false

func _input(event):
	if event.is_action_pressed("ui_pause"):
		if !paused:
			get_tree().paused = true
			paused = true
			pauseScreen.show()
			SignalBus.pause_game.emit()
		elif paused:
			get_tree().paused = false
			paused = false
			pauseScreen.hide()
			SignalBus.unpause_game.emit()
