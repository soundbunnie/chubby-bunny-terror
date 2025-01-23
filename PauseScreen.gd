extends CanvasLayer

@onready var quitButton = $PauseMenu/Quit

var paused = false

var quitConfirm = false

func pause():
	if !paused:
		get_tree().paused = true
		paused = true
		show()
		SignalBus.pause_game.emit()
	elif paused:
		get_tree().paused = false
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
