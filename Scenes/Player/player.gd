extends CharacterBody2D
class_name Player

@export var speed: float = 100.0
@export var push_force: float = 100.0
@export var disable_movement: bool = false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite.play("up")


func _physics_process(delta: float):
	if disable_movement:
		return
	_handle_input(delta)
	move_and_slide()
	_handle_collisions()
	
	
func _handle_input(delta: float) -> void:
	var x_axis: float = Input.get_axis("left", "right")
	var y_axis: float = Input.get_axis("up", "down")
	
	if x_axis == 0 and y_axis == 0:
		_set_idle_animations()
		return
		
	var input: Vector2 = Vector2(x_axis, y_axis).normalized()
	position += input * speed * delta
	
	_set_movement_animations(input)
		
		
func _set_movement_animations(input: Vector2) -> void:
	if input.x != 0:
		animated_sprite.play("side")
		if input.x < 0:
			animated_sprite.flip_h = false
		elif input.x > 0:
			animated_sprite.flip_h = true
	elif input.y > 0:
		animated_sprite.play("down")
	elif input.y < 0:
		animated_sprite.play("up")


func _set_idle_animations() -> void:
	animated_sprite.stop()
	if animated_sprite.animation == "down":
		animated_sprite.play("down_idle")
	elif animated_sprite.animation == "side":
		animated_sprite.play("side_idle")
		
		
func _handle_collisions() -> void:
	for index in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(index)
		var rigid_body: RigidBody2D = collision.get_collider() as RigidBody2D
		if rigid_body != null and rigid_body.is_in_group("Moveable"):
			rigid_body.apply_central_impulse(-collision.get_normal() * push_force)
