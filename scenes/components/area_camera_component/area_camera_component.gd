@tool
class_name AreaCameraComponent
extends Area2D

signal on_player_entered()
signal on_player_exit()

var is_active: bool = false

var camera: PhantomCamera2D = null
var old_priority = -1

func _ready() -> void:
    if not is_valid():
        push_error("ERROR: Camera missing!")
        return
    
    camera = get_child(1) as PhantomCamera2D
    
    body_entered.connect(area_body_entered)
    body_exited.connect(area_body_exited)
    collision_layer = 0
    collision_mask = 2048
    
    on_player_exit.emit()

func area_body_entered(_body) -> void:
    old_priority = camera.priority
    camera.priority = 1
    is_active = true
    on_player_entered.emit()
    get_tree().create_timer(0.1).timeout.connect(
        func():
            if is_instance_valid(Player.instance) and not Player.instance.hitbox.died:
                Game.save_checkpoint()
    )

func area_body_exited(_body) -> void:
    camera.priority = old_priority
    is_active = false
    on_player_exit.emit()

func _get_configuration_warnings() -> PackedStringArray:
    var warnings = []
    if not is_valid():
        warnings.append("[Area Camera]: Please a camera to this camera!")
        return warnings
    var ocamera = get_child(1) as PhantomCamera2D
    ocamera.limit_target = ocamera.get_path_to(get_child(0))
    return warnings

func is_valid() -> bool:
    if get_child_count() < 2:
        return false
    var ocamera = get_child(1)
    if ocamera is PhantomCamera2D or ocamera is Camera2D:
        return true
    return false
