extends AnimationPlayer

@export var manual_anim: bool = true

var _prev_tick: float = 0.0
var _anim_t: float = 0.0

func _ready() -> void:
    Game.on_pause.connect(_handle_pause)

func _process(delta: float) -> void:
    if is_playing() and get_tree().paused and Engine.time_scale == 0.0 and manual_anim:
        var ctick = Time.get_ticks_msec() / 1000.0
        delta = ctick - _prev_tick
        self.seek(_anim_t, true)
        _anim_t += delta
        _prev_tick = ctick
        if _anim_t > self.current_animation_length:
            self.animation_finished.emit(self.current_animation)

func _handle_pause() -> void:
    if is_playing():
        _prev_tick = Time.get_ticks_msec() / 1000.0
        _anim_t = 0.0
