extends Node2D

func _ready():
	var music: AudioStreamPlayer = $"AudioStreamPlayer"
	music.finished.connect(func(): music.playing = true)

