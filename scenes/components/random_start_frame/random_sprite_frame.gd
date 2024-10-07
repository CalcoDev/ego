extends AnimatedSprite2D

func _ready() -> void:
    #get_tree().create_timer(randf_range(0.0, 0.05)).timeout.connect(func():
            var mx = sprite_frames.get_frame_count(animation)
            frame = randi_range(0, mx - 1)       
    #)
