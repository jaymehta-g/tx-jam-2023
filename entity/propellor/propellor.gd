extends Node2D

@export var strength: float
@export var coll_shape: CollisionShape2D

@export var particles_scene: PackedScene

var facing_multiplier: float
var particles: GPUParticles2D

func _ready() -> void:
	if OS.get_name() == "Windows":
		var node = particles_scene.instantiate()
		add_child(node)
		particles = node
	$"Timer".timeout.connect(func(): 
		if particles:
			particles.emitting = false
		coll_shape.queue_free()
		$"Wait To Erase Timer".start()
	)



func init(player):
	if particles:
		particles.process_material.gravity.x *= player.facing_right_multiplier
	facing_multiplier = player.facing_right_multiplier

func _on_area_2d_body_entered(body:Node2D) -> void:
	if not body is Player:
		return
	var player := body as Player
	if player.current_state.name.to_lower() == "dash":
		return
	player.bounce(Vector2.RIGHT.rotated(-0.2) * facing_multiplier, strength)
