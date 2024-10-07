class_name HitboxComponent
extends Area2D

enum Faction {
    Player,
    Enemy
}

signal on_take_damage(other: HitboxComponent, damage: int)
signal on_deal_damage(other: HitboxComponent, damage: int)
signal on_died()

@export var faction: Faction = Faction.Enemy

@export_group("Health")
@export var health: int = 0
@export var take_damage_cooldown: float = 0.15

@export_group("Damage")
@export var damage: int = 1
@export var deal_damage_cooldown: float = 0.15

var died: bool = false

var _take_timer: SceneTreeTimer
var _deal_timer: SceneTreeTimer

func try_to_hit(to_hit: HitboxComponent, dmg: int) -> void:
    if not is_instance_valid(to_hit._take_timer) or to_hit._take_timer.time_left <= 0.0:
        to_hit._take_timer = get_tree().create_timer(to_hit.take_damage_cooldown)
        self._deal_timer = get_tree().create_timer(deal_damage_cooldown)
        to_hit.health -= dmg
        to_hit.on_take_damage.emit(self, dmg)
        self.on_deal_damage.emit(to_hit, dmg)
        print(to_hit.health)
        if to_hit.health <= 0:
            to_hit.died = true
            to_hit.on_died.emit()

func _ready() -> void:
    self.area_entered.connect(_on_area_entered)

func _on_area_entered(other: Area2D) -> void:
    if other is not HitboxComponent:
        return
    if other.faction == faction:
        return
    try_to_hit(other, self.damage)
