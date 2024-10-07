extends Node2D

@export var dia_id: String = "sign"

func _ready() -> void:
    for child in get_children():
        if child is DialogueInteraction:
            child.id = dia_id
