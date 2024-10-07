class_name Enemy
extends CharacterBody2D

@export var disabled: bool = false

@export var hell_scream_time: Vector2 = Vector2.ZERO
@onready var hell_scream_sfx = $"hell_scream_sfx"

@export var step_interval: float = 0.0
@onready var step_sfx = $"step_sfx"
var _step_timer: float = 0.0

@onready var particles = $"SpriteCenter/GPUParticles2D"
@onready var particles_sfx = $"particles_shot_sfx"

@export_group("Movement")
@export var WallSlideAngle: float = 30
@export var MovementSpeed: float = 100

@export_group("Area Stuff")
@export var area: AreaCameraComponent = null
@export var chase_only_area: bool = true
@export var paused_outside_area: bool = true

@onready var nav: NavigationAgent2D = $"NavigationAgent2D"

func _ready() -> void:
    if disabled:
        return
    if area != null:
        area.on_player_entered.connect(
            func():
                if paused_outside_area:
                    self.process_mode = Node.PROCESS_MODE_INHERIT
        )
        area.on_player_exit.connect(
            func():
                if paused_outside_area:
                    self.process_mode = Node.PROCESS_MODE_DISABLED
        )
        if paused_outside_area:
            self.process_mode = Node.PROCESS_MODE_DISABLED
    
    var m = hell_scream_time
    get_tree().create_timer(randf_range(m.x, m.y)).timeout.connect(_scream_timeout)

    #particles.restart()
    #particles.finished.connect(_on_particles_finished)
    get_tree().create_timer(0.0).timeout.connect(_on_particles_finished)

func _on_particles_finished() -> void:
    if disabled:
        return
    particles.restart()
    particles_sfx.play()
    get_tree().create_timer(particles.lifetime).timeout.connect(_on_particles_finished)

func _scream_timeout() -> void:
    if disabled:
        return
    if not is_instance_valid(self):
        return
    hell_scream_sfx.play()
    var m = hell_scream_time
    get_tree().create_timer(randf_range(m.x, m.y)).timeout.connect(_scream_timeout)

func _process(delta: float) -> void:
    if disabled:
        return
    if is_instance_valid(Player.instance):
        if area != null and chase_only_area and not area.is_active:
            return
        nav.target_position = Player.instance.global_position
        var path_pos = nav.get_next_path_position()
        var dir = (path_pos - global_position).normalized()
        var move = dir * MovementSpeed
        MoveAndCollide(move * delta)
        
        if move.length() > 0.01:
            _step_timer += delta
            if _step_timer > step_interval and not step_sfx.is_playing:
                step_sfx.play()
                _step_timer = 0.0

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
