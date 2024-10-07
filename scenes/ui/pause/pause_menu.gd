extends Node2D

@export var back:  Button
@export var menu: Button

@export var music: Slider
@export var sfx: Slider

func _ready() -> void:
    _setup_slider(&"music", music)
    _setup_slider(&"sfx", sfx)
    
    back.pressed.connect(Game.resume)
    menu.pressed.connect(Game.main_menu)
    
    for b in [back, menu]:
        _setup_button(b)

func _setup_button(b: Button) -> void:
    b.pressed.connect(_play_click)
func _play_click() -> void:
    Audio.map["blip_menu"].play()

func _setup_slider(bus_name: StringName, slider: Slider) -> void:
    self.visibility_changed.connect(func():
        var bus_indexxx = AudioServer.get_bus_index(bus_name)
        var valuee = db_to_linear(AudioServer.get_bus_volume_db(bus_indexxx))
        slider.value = valuee)
    var bus_index = AudioServer.get_bus_index(bus_name)
    var value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
    slider.value_changed.connect(_on_value_changed.bind(bus_index))
    slider.value = value

func _on_value_changed(value: float, bus_index: int) -> void:
    AudioServer.set_bus_volume_db(
        bus_index,
        linear_to_db(value)
    )
