extends Camera3D

@onready var noise = FastNoiseLite.new()

@export_range(0, 2) var amplitude: float = 0.5
@export_range(0, 2) var trauma: float = 0.8

var trauma_power = 2
var NOISE_SPEED = 50
var _noise_y = 0


func _ready():
	randomize()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _shake():
	var amount = pow(trauma, trauma_power)
	position = (
		Vector3(
			noise.get_noise_2d(noise.seed, _noise_y),
			noise.get_noise_2d(noise.seed*2, _noise_y),
			0,
		)
		* amplitude * amount
	)


func _physics_process(delta: float):
	_noise_y += delta * NOISE_SPEED
	_shake()
