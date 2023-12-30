extends Area2D
class_name Boost

@export var object_force: float = 100.0
@export var player_force: float = 2.0

var bodies: Array[Node2D]

@onready var current_direction = Vector2.UP.rotated(rotation)


func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	
	
func _physics_process(delta: float) -> void:
	for body in bodies:
		if body is RigidBody2D:
			body.apply_central_impulse(current_direction * object_force)
		elif body is Player:
			body.position += current_direction * player_force
			

	
func _on_body_entered(body: Node2D) -> void:
	if body not in bodies:
		bodies.append(body)

	
func _on_body_exited(body: Node2D) -> void:
	var body_index = bodies.find(body)
	if body_index != -1:
		bodies.remove_at(body_index)
