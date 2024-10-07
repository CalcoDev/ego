extends Node2D

var d: Dictionary = {}

@export var grid_size: Vector2i = Vector2i(320, 180)

func _ready() -> void:
    for c in get_children():
        if c is Light2D:
            var p = c.global_position
            var rp = Vector2i(c.global_position) / grid_size
            if rp not in d:
                d[rp] = []
            d[rp].append(c)
            c.visible = false

var _pp: Vector2i = Vector2i.ZERO
func _process(_delta: float) -> void:
    if is_instance_valid(Player.instance) and not Player.instance.hitbox.died:
        var rp = Vector2i(Player.instance.global_position) / grid_size
        if rp != _pp and rp in d:
            for i in 3:
                for j in 3:
                    var offset = Vector2i(i - 1, j - 1)
                    set_block(_pp + offset, false)
            for i in 3:
                for j in 3:
                    var offset = Vector2i(i - 1, j - 1)
                    set_block(rp + offset, true)
            _pp = rp
            
            
func set_block(coords: Vector2i, state: bool) -> void:
    if coords in d:
        for c in d[coords]:
            c.visible = state
