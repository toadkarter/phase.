extends Area2D
class_name Water

@export var box_drop_threshold: float = 7.0

var current_crate: Crate = null

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_collider: CollisionShape2D = $StaticBody2D/PlayerCollider


func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	

func _physics_process(_delta: float) -> void:
	if current_crate != null:
		var distance: float = position.distance_to(current_crate.position)
		if distance < box_drop_threshold:
			current_crate.queue_free()
			animated_sprite.play("drop_block")
			player_collider.disabled = true
	
	
func _on_body_entered(body: Node2D):
	if body is Crate:
		current_crate = body as Crate
		
		
func _on_body_exited(body: Node2D):
	if body is Crate and current_crate:
		current_crate = null
