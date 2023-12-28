extends CharacterBody2D

@export var speed: float = 100.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta):
	var previous_horizontal: float = velocity.x
	var previous_vertical: float = velocity.y
	
	var horizontal_direction = Input.get_axis("left", "right")
	var vertical_direction = Input.get_axis("up", "down")
	
	if previous_vertical != 0.0:
		_handle_vertical_movement(vertical_direction)
	elif previous_horizontal != 0.0:
		_handle_horizontal_movement(horizontal_direction)
	else:
		_handle_vertical_movement(vertical_direction)
		_handle_horizontal_movement(horizontal_direction)

	move_and_slide()
	

func _handle_vertical_movement(current_direction: float) -> void:
	var previous_velocity: float = velocity.y
	
	if current_direction:
		velocity.y = current_direction * speed
		if velocity.y < 0:
			animated_sprite.play("up")
		elif velocity.y > 0:
			animated_sprite.play("down")
	else:
		velocity.y = 0
		if previous_velocity < 0:
			animated_sprite.play("up")
		elif previous_velocity > 0:
			animated_sprite.play("down_idle")
		
		
func _handle_horizontal_movement(current_direction: float) -> void:
	var previous_velocity: float = velocity.x
	
	if current_direction:
		velocity.x = current_direction * speed
		if velocity.x != 0:
			animated_sprite.play("side")
			_set_flip_orientation()
	else:
		velocity.x = 0 
		animated_sprite.play("side_idle")
		
		
func _set_flip_orientation() -> void:
	if velocity.x > 0 and !animated_sprite.flip_h:
		animated_sprite.flip_h = true
	elif velocity.x < 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
