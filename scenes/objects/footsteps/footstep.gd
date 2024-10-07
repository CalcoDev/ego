extends Node2D

@export var lifetime: float = 0.3
@export var randomness: float = 0.1

func _ready() -> void:
    var anim: AnimatedSprite2D = $"AnimatedSprite2D"
    var mx = anim.sprite_frames.get_frame_count("default") - 1
    anim.frame = randi_range(0, mx)
    var t = create_tween()
    var d = randf_range(
        lifetime * (1.0 - randomness),
        lifetime * (1.0 + randomness)
    )
    t.tween_property(self, "modulate", Color8(255, 255, 255, 0), d)\
        .set_ease(Tween.EASE_IN)
    t.tween_callback(queue_free)
    t.play()
