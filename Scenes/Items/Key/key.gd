extends Area2D
class_name Key

signal collected


func _ready():
	connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collected.emit()
		queue_free()
	
