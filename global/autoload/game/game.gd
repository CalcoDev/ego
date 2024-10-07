extends Node

signal on_pause()
signal on_unpause()

@onready var anim: AnimationPlayer = $"AnimationPlayer"

@export var enemy_prefab: PackedScene = null

@export var pause_menu: CanvasLayer = null

var unscaled_delta_time: float = 0.0

var is_in_gameplay: bool = false
var is_in_pause_menu: bool = false

func _ready() -> void:
    __prev_tick_delta = Time.get_ticks_msec() / 1000.0
    anim.play("fade_out")
    anim.seek(999, true)
    resume()
    RenderingServer.set_default_clear_color(Color.BLACK)


var _fulscr: bool = false
var _prev_tick: float = 0.0
var __prev_tick_delta: float = 0.0
var _godmode: bool = false
func _process(delta: float) -> void:
    if Input.is_action_just_pressed("godmode"):
        if is_instance_valid(Player.instance): 
            _godmode = !_godmode
            if _godmode:
                Player.instance.hitbox.collision_layer = 0
                Player.instance.collision_mask = 0
            else:
                Player.instance.hitbox.collision_layer = 256
                Player.instance.collision_mask = 2
    if Input.is_action_just_pressed("fullscr"):
        _fulscr = !_fulscr
        if _fulscr:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
        else:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
    
    var ctick = Time.get_ticks_msec() / 1000.0
    unscaled_delta_time = ctick - __prev_tick_delta
    __prev_tick_delta = ctick
    if Engine.time_scale == 0.0 and _manual_anim:
        delta = ctick - _prev_tick
        anim.seek(_anim_t, true)
        _anim_t += delta
        _prev_tick = ctick
        if _anim_t > anim.current_animation_length:
            anim.animation_finished.emit(anim.current_animation)
    if Input.is_action_just_pressed("escape") and is_in_gameplay:
        if not get_tree().paused:
            pause(true)
        elif is_in_pause_menu:
            resume()

# PAUSE
var _anim_t: float = 0.0
var _manual_anim: bool = false
func pause(menu: bool = false) -> void:
    #Engine.time_scale = 0.0
    get_tree().paused = true
    if menu:
        is_in_pause_menu = true
        pause_menu.visible = true
    else:
        is_in_pause_menu = false
    on_pause.emit()

func resume() -> void:
    #Engine.time_scale = 1.0
    get_tree().paused = false
    pause_menu.visible = false
    is_in_pause_menu = false
    on_unpause.emit()

var player_tp_to_pos: Vector2 = Vector2.ZERO

# SCENES
var scenes: Dictionary = {
    "main_menu": preload("res://scenes/ui/main/main_menu.tscn"),
    "gameplay": preload("res://scenes/game_flow/map.tscn"),
    "wheat_character_select": preload("res://scenes/game_flow/wheat_character_select/scene_character_select.tscn"),
    "final_scene": preload("res://scenes/game_flow/final_scene/final_scene.tscn")
}

var checkpoint_enemy_objects: Array = []

var dialogue_truth: Dictionary = {}

var player_health: int = 0
var player_died: bool = 0

func save_checkpoint() -> void:
    print("saving checkpoint")
    checkpoint_enemy_objects.clear()
    for e: Enemy in get_tree().get_nodes_in_group("enemy"):
        var d = {}
        d["parent"] = e.get_parent()
        d["global_position"] = e.global_position
        checkpoint_enemy_objects.append(d)
        print("adding enemy to spawn list, ", e.global_position)
    player_tp_to_pos = Player.instance.global_position
    dialogue_truth = DiaReg.truth.duplicate()
    player_health = Player.instance.hitbox.health
    player_died = Player.instance.hitbox.died

func reset_to_checkpoint() -> void:
    print("loading checkpoint")
    # Remove old enemies
    for enemy: Enemy in get_tree().get_nodes_in_group("enemy"):
        enemy.queue_free()
    for e in checkpoint_enemy_objects:
        var en: Enemy = enemy_prefab.instantiate()
        en.global_position = e["global_position"]
        e["parent"].add_child(en)
        en.global_position = e["global_position"]
        print("spawning enemy at ", en.global_position)
    
    # Reset dialogue truth
    DiaReg.truth = dialogue_truth
    
    # Reset player
    Player.instance.global_position = player_tp_to_pos
    Player.instance.sprite.play("default")
    Player.instance.hitbox.health = player_health
    Player.instance.hitbox.died = player_died

func main_menu() -> void:
    Game.is_in_gameplay = false
    await switch_scene("main_menu", resume)

func start_game() -> void:
    await switch_scene("gameplay")
    DiaReg.truth = {}
    Game.is_in_gameplay = true

func wheat_character_select() -> void:
    print("aaaa")
    $"Wheat/CanvasLayer".visible = true
    $"Wheat/CanvasLayer".process_mode = Node.PROCESS_MODE_ALWAYS
    $"Wheat".visible = true
    $"Wheat".process_mode = Node.PROCESS_MODE_ALWAYS

func go_back_to_gameplay() -> void:
    #await switch_scene("gameplay")
    $"Wheat".queue_free()
    Player.instance.global_position = player_tp_to_pos
    get_tree().create_timer(0.4).timeout.connect(
        func():
            await DiaReg.play("back_from_wheat")
    )

func quit_game() -> void:
    # LMFAO
    Game.is_in_gameplay = false
    get_tree().quit()

func switch_scene(new_scene_id: String, callback: Callable = _no_callback) -> void:
    assert(new_scene_id in scenes)
    for c in Audio.map:
        Audio.map[c].stop()
    anim.play(&"fade_in")
    if Engine.time_scale == 0.0:
        _manual_anim = true
        _prev_tick = Time.get_ticks_msec() / 1000.0
        _anim_t = 0.0
    await anim.animation_finished
    callback.call()
    get_tree().change_scene_to_packed(scenes[new_scene_id])
    anim.play(&"fade_out")
    if Engine.time_scale == 0.0:
        _manual_anim = true
        _prev_tick = Time.get_ticks_msec() / 1000.0
        _anim_t = 0.0
    await anim.animation_finished

func _no_callback() -> void:
    pass
