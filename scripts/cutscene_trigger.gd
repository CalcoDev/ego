extends Area2D

@export var anim: AnimationPlayer
@export var anim_id: String = ""

var done: bool = false
func _ready() -> void:
    collision_layer = 0
    collision_mask = 1
    body_entered.connect(_on_body_entered)
    
func _on_body_entered(body: Node2D) -> void:
    if not done and body is Player:
        anim.play(anim_id)
        done = true
