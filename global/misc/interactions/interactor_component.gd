class_name InteractorComponent
extends Area2D

func try_to_interact() -> bool:
    if _body_action == null:
        return false
    _body_action.interact(self)
    return true

var _body_action: InteractionComponent = null
var _bodies: Dictionary = {}
var _min_dist: float = -1

func _ready() -> void:
    area_entered.connect(_on_area_entered)
    area_exited.connect(_on_area_exited)

func _on_area_entered(area) -> void:
    if not area is InteractionComponent:
        return
    _bodies[area] = true
    var dist = area.global_position.distance_to(global_position)
    if _min_dist < 0 or dist < _min_dist:
        _min_dist = 0
        if _body_action != null:
            _body_action.hide_interaction()
        _body_action = area as InteractionComponent
        _body_action.display_interaction()

func _on_area_exited(area) -> void:
    if not area is InteractionComponent:
        return
    _bodies.erase(area)
    if _bodies.size() == 0:
        _min_dist = -1
        _body_action.hide_interaction()
        _body_action = null
