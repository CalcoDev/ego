extends Node2D

func _ready() -> void:
    Game.is_in_gameplay = true
    (Audio.map["elevator_noise"] as AudioStreamPlayer).play()
