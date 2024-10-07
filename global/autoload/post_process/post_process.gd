class_name PostProcess
extends Node2D

static var instance: PostProcess

@onready var lens_distortion: ShaderMaterial = $"LensDistortion".material
@onready var chroma_abber: ShaderMaterial = $"ChromaticAbberation".material
@onready var vignette: ShaderMaterial = $"Vignette".material
@onready var glitch: ShaderMaterial = $"Glitch".material

func _notification(what: int) -> void:
    if what == NOTIFICATION_SCENE_INSTANTIATED:
        instance = self

func _enter_tree() -> void:
    instance = self

func set_glitch_opacity(value: Color) -> void:
    var t: GradientTexture2D = get_child(7).texture
    t.gradient.set_color(0, value)
