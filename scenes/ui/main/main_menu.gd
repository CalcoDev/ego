extends Node2D

@export_group("Main")
@export var main: Control
@export var play: Button
@export var settings: Button
@export var quit: Button

@export_group("Pause")
@export var pause: Control
@export var back:  Button

@export var music: Slider
@export var sfx: Slider

func _exit_tree() -> void:
    Audio.map["main_menu_theme"].stop()

func _ready() -> void:
    for b in [play, settings, quit, back]:
        _setup_button(b)
    
    Audio.map["main_menu_theme"].play()
    
    Game.is_in_gameplay = false
    main.visible = true
    pause.visible = false
    play.pressed.connect(Game.start_game)
    settings.pressed.connect(func():
        main.visible = false
        pause.visible = true)
    quit.pressed.connect(Game.quit_game)
    
    _setup_slider(&"music", music)
    _setup_slider(&"sfx", sfx)
    
    back.pressed.connect(func():
        main.visible = true
        pause.visible = false)

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
