extends Area2D
class_name Switch

signal on
signal off

@onready var up_sprite: Sprite2D = $UpSprite
@onready var down_sprite: Sprite2D = $DownSprite


func _ready():
	_set_switch_off()
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	
	
func _on_body_entered(_body: Node2D) -> void:
	_set_switch_on()
	

func _on_body_exited(_body: Node2D) -> void:
	_set_switch_off()
	
	
func _set_switch_on() -> void:
	up_sprite.visible = false
	down_sprite.visible = true
	on.emit()
	
	
func _set_switch_off() -> void:
	up_sprite.visible = true
	down_sprite.visible = false
	off.emit()
