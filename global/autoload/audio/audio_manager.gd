extends Node

#@export var low_pass: AudioEffectLowPassFilter:
    #get():
        #return AudioServer.get_bus_effect(0, 0)
#
#@export var distortion: AudioEffectDistortion:
    #get():
        #return AudioServer.get_bus_effect(0, 1)

var map: Dictionary:
    get:
        var d = {}
        for child in get_children():
            d[child.name] =  child
        return d

#func stop_all() -> void:
    #for 
