@tool
class_name InteractionComponent
extends Area2D

signal on_interacted(interactor: InteractorComponent)

func interact(interactor: InteractorComponent) -> void:
    on_interacted.emit(interactor)

func _interact(_actor: InteractorComponent) -> void:
    pass

func display_interaction():
    pass

func hide_interaction(_force_hide: bool=false):
    pass
    
func _enter_tree() -> void:
    if Engine.is_editor_hint():
        return

func _ready() -> void:
    if Engine.is_editor_hint():
        return
    hide_interaction(true)
    on_interacted.connect(_interact)
