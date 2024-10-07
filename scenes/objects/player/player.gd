class_name Player
extends CharacterBody2D

static var instance: Player = null

@onready var sprite: AnimatedSprite2D = $"AnimatedSprite2D"

@export_group("Movement")
@export var WallSlideAngle: float = 30
@export var MovementSpeed: float = 100

@export_group("Interactions")
@export var interactor_scaler: Node2D = null
@export var interactor: InteractorComponent = null

@export_group("Health")
@export var hitbox: HitboxComponent = null

@export_group("VFX")
@export var max_col_variance: float = 10.0

@export_group("SFX")
@export_subgroup("Steps")
@onready var footstep_comp: FootstepComponent = $"FootstepComponent"
@onready var step_sfx: AudioStreamPlayer = $"step_sfx"
@export var step_interval: float = 0.0
var _step_timer: float = 0.0

@export_subgroup("Enemy")
@export var enemy_dist_start: float = 100.0
@export var enemy_dist_max: float = 50

var _move = Vector2.ZERO

func reset_checkpoint() -> void:
    Game.reset_to_checkpoint()
    $"AnimationPlayer".play("RESET")

func _notification(what: int) -> void:
    if what == NOTIFICATION_SCENE_INSTANTIATED:
        instance = self

func _ready() -> void:
    hitbox.on_died.connect(_on_died)
    #footstep_comp.on_footstep.connect(_on_footstep)
#
#func _on_footstep(_pos: Vector2) -> void:
    #if not hitbox.died:
        #step_sfx.play()

var _shader_set: bool = false
func _process(delta):
    if hitbox.died:
        return
    
    # Input
    _move.x = Input.get_axis(&"left", &"right")
    _move.y = Input.get_axis(&"up", &"down")
    _move = _move.normalized()

    if Input.is_action_just_pressed("interact"):
        interactor.try_to_interact()

    # Update display
    if _move.x < 0.0 and not sprite.flip_h:
        sprite.flip_h = true
    elif _move.x > 0.0 and sprite.flip_h:
        sprite.flip_h = false 

    # Interactor movement
    if _move.length() > 0.01:
        var angle = _move.angle()
        interactor_scaler.rotation = angle

    # Handle enemystuff
    var enemies = get_tree().get_nodes_in_group("enemy")
    var min_enemy_dist: float = 999.9
    for enemy: Enemy in enemies:
        if not is_vis(enemy, 3):
            continue
        var dist = global_position.distance_to(enemy.global_position)
        if dist < min_enemy_dist:
            min_enemy_dist = dist
    if min_enemy_dist < enemy_dist_start:
        var x = min_enemy_dist
        var norm = clamp(abs(x - enemy_dist_start) / (abs(enemy_dist_max - enemy_dist_start)), 0.0, 1.0)
        var audio = Audio.map["enemy_glitch"]
        if not audio.playing:
            audio.play()
        audio.volume_db = linear_to_db(norm)
        #print(PostProcess.instance)
        var s = PostProcess.instance.chroma_abber
        var r = lerp(1.72, 0.0, norm)
        var c = Vector2(
            max_col_variance * norm * randf_range(0.8, 1.2),
            0.0
        )
        s.set_shader_parameter(&"outer_radius", r)
        s.set_shader_parameter(&"r_displacement", c)
        s.set_shader_parameter(&"b_displacement", c)
        var g = PostProcess.instance.glitch
        PostProcess.instance.get_child(7).visible = true
        PostProcess.instance.set_glitch_opacity(Color(0.0, 0.0, 0.0, norm))
        var v = lerp(0.002, 0.01, norm)
        g.set_shader_parameter(&"shake_power", v)
        v = lerp(0.002, 0.008, norm)
        g.set_shader_parameter(&"shake_color_rate", v)
        _shader_set = true
    else:
        if Audio.map["enemy_glitch"].playing:
            Audio.map["enemy_glitch"].stop()
        if _shader_set:
            var s = PostProcess.instance.chroma_abber
            s.set_shader_parameter(&"outer_radius", 1.72)
            s.set_shader_parameter(&"r_displacement", Vector2(3.0, 0.0))
            s.set_shader_parameter(&"b_displacement", Vector2(-3.0, 0.0))
            PostProcess.instance.get_child(7).visible = false
            _shader_set = false
    
    # Update post processing and audio
    if _move.length() > 0.01:
        _step_timer += delta
        if _step_timer > step_interval:
            step_sfx.play()
            _step_timer = 0.0

    # Actual movement
    _move = _move * MovementSpeed * delta
    MoveAndCollide(Vector2.RIGHT * _move.x)
    MoveAndCollide(Vector2.DOWN * _move.y)

func is_vis(node: Node2D, depth: int = 2) -> bool:
    var n = node
    for i in depth:
        if not n.visible:
            return false
        n = n.get_parent()
        if n == get_tree().root:
            return true
    return true

# Death
func _on_died() -> void:
    self.process_mode = Node.PROCESS_MODE_ALWAYS
    #Game.pause(false)
    #Audio.low_pass.
    
    sprite.z_index = 400
    sprite.play("death")
    sprite.process_mode = Node.PROCESS_MODE_ALWAYS
    $"AnimationPlayer".process_mode = Node.PROCESS_MODE_ALWAYS
    $"AnimationPlayer".play("death")
    await $"AnimationPlayer".animation_finished
    Audio.map["player_die"].play()
    await sprite.animation_finished
    self.process_mode = Node.PROCESS_MODE_INHERIT
    sprite.process_mode = Node.PROCESS_MODE_INHERIT
    $"AnimationPlayer".process_mode = Node.PROCESS_MODE_INHERIT

var _d = Vector2.ZERO
var _d1 = Vector2.ZERO
func MoveAndCollide(motion: Vector2):
    var col = move_and_collide(Vector2.RIGHT * motion.x)
    if col != null:
        var norm = col.get_normal()
        var dir = get_perpendicular(norm)
        var ang = norm.angle_to(motion)
        if ang > 0:
            dir.x *= - 1
            dir.y *= - 1
        if PI - abs(ang) > deg_to_rad(WallSlideAngle):
            move_and_collide(dir * col.get_remainder().length())
    col = move_and_collide(Vector2.DOWN * motion.y)
    if col != null:
        var norm = col.get_normal()
        var dir = get_perpendicular(norm)
        var ang = norm.angle_to(motion)
        if ang > 0:
            dir.x *= - 1
            dir.y *= - 1
        if PI - abs(ang) > deg_to_rad(WallSlideAngle):
            move_and_collide(dir * col.get_remainder().length())
 
func v2_v3(vec):
    return Vector2(vec.x, vec.z)

func v3_v2(vec):
    return Vector3(vec.x, 0, vec.y)

func get_perpendicular(vec):
    return v2_v3(Vector3.UP.cross(v3_v2(vec)))

func _draw():
    draw_line(Vector2.ZERO, _d * 100, Color.DARK_BLUE, 2)
    draw_line(Vector2.ZERO, _d1 * 100, Color.DARK_RED, 2)
    pass
