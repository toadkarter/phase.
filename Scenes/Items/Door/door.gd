extends Area2D
class_name Door

signal entered

@export var switch: Switch

var is_open: bool = true

@onready var opened_sprite: Sprite2D = $OpenedSprite
@onready var closed_sprite: Sprite2D = $ClosedDoor/ClosedSprite
@onready var closed_door_collider: CollisionShape2D = $ClosedDoor/ClosedDoorCollider

func _ready():
	_open_door()
	_init_switch()
	connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		entered.emit()


func _open_door() -> void:
	opened_sprite.visible = true
	closed_sprite.visible = false
	closed_door_collider.disabled = true
	is_open = true
	
	
func _close_door() -> void:
	opened_sprite.visible = false
	closed_sprite.visible = true
	closed_door_collider.disabled = false
	is_open = false
	
	
func _init_switch() -> void:
	if switch == null:
		return
	switch.connect("on", _handle_switch_on)
	switch.connect("off", _handle_switch_off)
	
	
func _handle_switch_on() -> void:
	if !is_open:
		_open_door()
	

func _handle_switch_off() -> void:
	if is_open:
		_close_door()
