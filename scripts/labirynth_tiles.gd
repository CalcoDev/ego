extends TileMapLayer

@export var labirynth_area: AreaCameraComponent = null
@export var player_in_labirynth: bool = false

@export var lights: Node2D = null
@export var light: PackedScene = null
var _lights: Dictionary = {}

func _ready() -> void:
    labirynth_area.on_player_entered.connect(_on_player_entered)
    labirynth_area.on_player_exit.connect(_on_player_exit)
    
    for cell in get_used_cells_by_id(3, Vector2i(1, 0)):
        set_cell(cell, 3, Vector2i(0, 1))

func _process(_delta: float) -> void:
    if not player_in_labirynth:
        return
    var pos = Player.instance.global_position
    var map_pos = local_to_map(to_local(pos))
    var tile = get_cell_tile_data(map_pos)
    if tile == null:
        return
    if map_pos not in _lights:
        set_cell(map_pos, 3, Vector2i(1, 1))
        #var l = light.instantiate()
        #l.global_position = to_global(map_to_local(map_pos))
        #lights.add_child(l)
        _lights[map_pos] = true

func _on_player_entered() -> void:
    player_in_labirynth = true

func _on_player_exit() -> void:
    player_in_labirynth = false
