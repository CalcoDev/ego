extends AnimationPlayer

func _ready() -> void:
    DiaReg.cutscene = self

func play_sound(sound_id: String) -> void:
    Audio.map[sound_id].play()
