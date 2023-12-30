extends Area2D
class_name Door

signal entered

@export var switch: Switch
@export var key: Key

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
	call_deferred("_set_closed_door_collider", false)
	is_open = true
	
	
func _close_door() -> void:
	opened_sprite.visible = false
	closed_sprite.visible = true
	call_deferred("_set_closed_door_collider", true)
	is_open = false
	
	
func _init_switch() -> void:
	if switch != null:
		switch.connect("on", _handle_door_open)
		switch.connect("off", _handle_door_closed)
		
	if key != null:
		key.connect("collected", _handle_door_open)
		
	
	
func _handle_door_open() -> void:
	if !is_open:
		_open_door()
	

func _handle_door_closed() -> void:
	if is_open:
		_close_door()
		
		
func _set_closed_door_collider(on: bool) -> void:
	closed_door_collider.disabled = !on
