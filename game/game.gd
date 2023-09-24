extends Node2D

func _ready():
	var music: AudioStreamPlayer# = $"AudioStreamPlayer"
	if music:
		music.finished.connect(func(): music.playing = true)
	
	# more debugging crap:
	$"Shop Item".init(TrapType.Types.TRAMPOLINE)

