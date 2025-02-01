extends Control

@onready var pauseScreen = $PauseScreen

@onready var quitButton = $PauseScreen/PauseMenu/Quit

var paused:bool = false

var quitConfirm:bool = false

func _input(event):
	if event.is_action_pressed("ui_pause"):
		pauseScreen.pause()
