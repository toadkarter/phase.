extends Area2D
class_name Boost

@export var force = 100.0

var bodies: Array[Node2D]


func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	
	
func _physics_process(delta: float) -> void:
	# rotation 0 = up
	# rotation
	for body in bodies:
		if body is RigidBody2D:
			body.apply_central_impulse(Vector2.UP.rotated(rotation) * force)

	
func _on_body_entered(body: Node2D) -> void:
	if body not in bodies:
		bodies.append(body)

	
func _on_body_exited(body: Node2D) -> void:
	var body_index = bodies.find(body)
	if body_index != -1:
		bodies.remove_at(body_index)
