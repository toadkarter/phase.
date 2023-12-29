extends Area2D
class_name Orb

signal changed_worlds(orb: Orb)

@export var _is_in_first_world = true

func _ready():
	connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		changed_worlds.emit()
		
		
func is_in_first_world() -> bool:
	return _is_in_first_world
