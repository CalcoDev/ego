class_name DialogueInteraction
extends InteractionComponent

@export var id: String = ""

func _interact(_interactor: InteractorComponent) -> void:
    await DiaReg.play(id)
