extends TileMapLayer

func _ready() -> void:
    for cell in get_used_cells_by_id(3, Vector2i(1, 0)):
        erase_cell(cell)
