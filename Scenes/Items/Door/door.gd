extends Area2D
class_name Door

signal entered

@export var start_opened: bool = true

@onready var opened_sprite: Sprite2D = $OpenedSprite
@onready var closed_sprite: Sprite2D = $ClosedDoor/ClosedSprite
@onready var closed_door_collider: CollisionShape2D = $ClosedDoor/ClosedDoorCollider


func _ready():
	if start_opened:
		_open_door()
	else: 
		_close_door()
	connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		entered.emit()


func _open_door() -> void:
	opened_sprite.visible = true
	closed_sprite.visible = false
	closed_door_collider.disabled = true
	
	
func _close_door() -> void:
	opened_sprite.visible = false
	closed_sprite.visible = true
	closed_door_collider.disabled = false
