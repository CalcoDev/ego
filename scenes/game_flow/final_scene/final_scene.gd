extends Node2D

func play_sound(id: String) -> void:
    for iid in Audio.map:
        if Audio.map[iid].playing:
            Audio.map[iid].stop()
    Audio.map[id].play()

func _ready() -> void:
    get_tree().create_timer(1).timeout.connect(
        func():
            Audio.map["ring_of_fire"].play()
    )
    get_tree().create_timer(236).timeout.connect(GOJO_COMEBACK_NOT_COPIUM)
    
    $"North".pressed.connect(
        func():
            OS.execute_with_pipe(OS.get_executable_path(), [])
            Game.quit_game()
    )
    $"South".pressed.connect(
        func():
            Game.quit_game()
    )

func GOJO_COMEBACK_NOT_COPIUM() -> void:
    $"AnimationPlayer".play("menace")
    $"AnimationPlayer".seek(9999, true)
