extends Node

@onready var shop_theme_mus = "shop theme wip"

func _ready():
	var first_level_music = shop_theme_mus
	SignalBus.change_music.emit(first_level_music)
