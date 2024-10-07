extends Area2D

@export var dia_id: String = ""
var done: bool = false

func _ready() -> void:
    collision_layer = 0
    collision_mask = 1
    body_entered.connect(_on_body_entered)
    
func _on_body_entered(body: Node2D) -> void:
    if not done and body is Player:
        if await DiaReg.play(dia_id):
            done = true
