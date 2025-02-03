extends Node


func _ready():
	# connect signals
	SignalBus.pause_game.connect(_on_game_paused)
	SignalBus.unpause_game.connect(_on_game_unpaused)
	
func _unhandled_input(event):
		if event.is_action_pressed("ui_pause"):
			if !Globals.paused:
				SignalBus.pause_game.emit()
			elif Globals.paused:
				SignalBus.unpause_game.emit()
	
func _notification(what):
	match what:
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			if !Globals.paused:
				SignalBus.pause_game.emit()

func _on_game_paused():
	Globals.paused = true
	get_tree().paused = true

func _on_game_unpaused():
	Globals.paused = false
	get_tree().paused = false
