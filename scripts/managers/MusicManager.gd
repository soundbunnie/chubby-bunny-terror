extends Node

@onready var shop_theme_mus = "shop theme wip"
@onready var theme_of_miranda = "Theme of Miranda"

var current_mus:String

func _ready():
	var first_level_music = shop_theme_mus
	current_mus = first_level_music
	SignalBus.change_music.emit(first_level_music)
