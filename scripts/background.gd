extends Node

@export var offset_speed: Vector3 = Vector3.ONE
@export var change_ampl: float = 3.0
@export var change_freq: float = 2.0

var _t: float = 0.0

var base_offset: Vector3 = Vector3.ZERO
var comp_offset: Vector3 = Vector3.ZERO

func _process(delta: float) -> void:
    var x = get_parent().global_position
    base_offset = Vector3(x.x, x.y, 0.0)
    comp_offset += offset_speed * delta
    var coff = (get_parent().texture as NoiseTexture2D).noise.offset
    (get_parent().texture as NoiseTexture2D).noise.offset = coff.lerp(base_offset + comp_offset, delta * 5.0)
    (get_parent().texture as NoiseTexture2D).noise.fractal_gain = sin(_t * change_freq) * change_ampl
    _t += delta
