extends Node

# IDK if we'll need this script yet - it used to be useful but I think we'll decide with future levels if we need a 
# music manager as well as conductor and audio manager

# @export variables
@onready var shop_theme_mus = "shop theme wip"
@onready var theme_of_miranda = "Theme of Miranda"

# private variables
var current_mus:String

func _ready():
	pass
	#var first_level_music = shop_theme_mus
	#current_mus = first_level_music
	#SignalBus.change_music.emit(first_level_music)
