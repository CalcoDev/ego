extends Node2D

signal on_finish_str()
signal on_next_screen()

@export var box: NinePatchRect = null
@export var txt_lbl: RichTextLabel = null

@export var anim: AnimationPlayer

var display_tween: Tween = null
var is_shown: bool = true

var is_playing: bool = false
var is_awaiting_input: bool = false
        
var cps: float = 0.0
var text: String = "":
    get():
        return text
    set(value):
        text = value
        txt_lbl.text = text

var __c: float = 0.0
var c: int = 0:
    get():
        return c
    set(value):
        c = value
        txt_lbl.visible_characters = c

func _ready() -> void:
    dia_hide(true)

func _process(delta: float) -> void:
    delta = Game.unscaled_delta_time
    if is_awaiting_input:
        if Input.is_action_just_pressed("dia_next"):
            on_next_screen.emit()
        return
    if is_playing:
        if Input.is_action_just_pressed("dia_skip"):
            __c = len(text)
        if txt_lbl.visible_ratio >= 1.0:
            if Audio.map["dialogue_typing"].playing:
                Audio.map["dialogue_typing"].stop()
            is_playing = false
            on_finish_str.emit()
            is_awaiting_input = true
        else:
            if not Audio.map["dialogue_typing"].playing:
                Audio.map["dialogue_typing"].play()
        __c = min(__c + delta * cps, len(text) + 1)
        c = floor(__c)

func play(t: String = "_no_str", _cps: float = -1.0, _c: int = 0) -> void:
    Audio.map["dialogue_typing"].play()
    if t != "_no_str":
        text = t
    if _cps > 0.0:
        cps = _cps
    c = _c
    __c = _c
    is_playing = true
    is_awaiting_input = false
    await on_next_screen

func dia_show(instant: bool = false, pause: bool = true) -> void:
    if is_shown:
        return
    #AudioServer.set_bus_effect_enabled(0, 0, false)
    #AudioServer.set_bus_effect_enabled(0, 1, false)
    Audio.map["blip"].play()
    is_shown = true
    anim.play("dia_show")
    if instant:
        anim.seek(1, true)
    else:
        if pause:
            Game.pause(false)
        await anim.animation_finished

func dia_hide(instant: bool = false) -> void:
    if not is_shown:
        return
    #AudioServer.set_bus_effect_enabled(0, 0, true)
    #AudioServer.set_bus_effect_enabled(0, 1, true)
    Audio.map["blip"].play()
    is_shown = false
    anim.play("dia_hide")
    Game.resume()
    if instant:
        anim.seek(1, true)
    else:
        await anim.animation_finished
