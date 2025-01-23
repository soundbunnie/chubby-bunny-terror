extends Control

@onready var pauseScreen = $PauseScreen

@onready var quitButton = $PauseScreen/PauseMenu/Quit

var paused = false

var quitConfirm = false

func _input(event):
	if event.is_action_pressed("ui_pause"):
		pause()

func pause():
	if !paused:
		get_tree().paused = true
		paused = true
		pauseScreen.show()
		SignalBus.pause_game.emit()
	elif paused:
		get_tree().paused = false
		paused = false
		quitConfirm = false
		quitButton.set_text("Quit")
		pauseScreen.hide()
		SignalBus.unpause_game.emit()

func _on_resume_pressed():
	pause()

func _on_quit_pressed():
	if !quitConfirm:
		quitButton.set_text("Are you sure?")
		quitConfirm = true
	elif quitConfirm:
		get_tree().quit()
