extends Node
@export var midi_player: MidiPlayer

# Conductor should be in charge of everything related to the rhythm and midi aspects of code
func _ready() -> void:
	midi_player.play() # let's try to play the actual song in AudioManager and see how these two scripts will interact

func _on_midi_player_midi_event(channel: Variant, event: Variant) -> void:
	if event.type == SMF.MIDIEventType.note_on: 
		SignalBus.note_played.emit(event.note, event.velocity)
	
