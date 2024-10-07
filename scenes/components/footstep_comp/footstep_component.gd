class_name FootstepComponent
extends Node2D

signal on_footstep(pos: Vector2)

@export var spawn: bool = true
@export var distance: float = 10.0
@export var min_time: float = 0.1

@export var footstep_scene: PackedScene = null

var _prev_spot: Vector2 = Vector2.ZERO

var _prev_time: float = 0.0
var _ctime: float = 0.0

var _prev_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
    _prev_spot = global_position

func _process(delta: float) -> void:
    _ctime += delta
    if spawn and _ctime - _prev_time > min_time and _prev_spot.distance_to(global_position) > distance:
        spawn_footstep()
        _prev_time = _ctime
        _prev_spot = global_position
    _prev_pos = global_position
        
func spawn_footstep() -> void:
    on_footstep.emit(global_position)
    var footstep = footstep_scene.instantiate() as Node2D
    var ysort = get_tree().get_nodes_in_group(&"ysort")[0] as Node2D
    footstep.global_position = global_position
    footstep.rotation = (global_position - _prev_spot).angle()
    footstep.z_index = -1
    ysort.add_child(footstep)
