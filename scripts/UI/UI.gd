extends Control

# private variables
var paused:bool = false
var quit_confirm:bool = false

# @onready variables
@onready var pause_screen = $PauseScreen
@onready var quit_button = $PauseScreen/PauseMenu/Quit

func _input(event):
	if event.is_action_pressed("ui_pause"):
		pause_screen.pause()
