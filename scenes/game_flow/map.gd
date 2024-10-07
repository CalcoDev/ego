extends Node2D

func _ready() -> void:
    Game.is_in_gameplay = true
    (Audio.map["elevator_noise"] as AudioStreamPlayer).play()

    var l = [self]
    while len(l) > 0:
        var c = l.pop_front()
        if "mouse_filter" in c:
            c.set("mouse_filter", Control.MOUSE_FILTER_IGNORE)
        for cc in c.get_children():
            l.append(cc)
