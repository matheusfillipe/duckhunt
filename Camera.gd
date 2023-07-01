extends Camera3D

@onready var noise = FastNoiseLite.new()
@onready var center_rotation: Vector3 = rotation

@export_range(0, 1) var shake_amplitude: float = 0.25

var NOISE_SPEED = 50
var _noise_y = 0


func _ready():
	randomize()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN


func _physics_process(delta: float):
	_noise_y += delta * NOISE_SPEED
	var shake_vec = (
		Vector3(
			noise.get_noise_2d(noise.seed, _noise_y),
			noise.get_noise_2d(noise.seed * 2, _noise_y),
			0,
		)
		* shake_amplitude
	)
	rotation = center_rotation + shake_vec
