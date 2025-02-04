extends Node
@export var midi_player: MidiPlayer

func _ready() -> void:
	midi_player.play()

func _on_midi_player_midi_event(channel: Variant, event: Variant) -> void:
	if event.type == SMF.MIDIEventType.note_on:
		SignalBus.spawn_carrot.emit()
		print(event.note)
