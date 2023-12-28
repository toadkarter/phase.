extends CharacterBody2D

@export var speed: float = 150.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta):
	var horizontal_direction = Input.get_axis("left", "right")
	var vertical_direction = Input.get_axis("up", "down")
	
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
	if current_direction:
		velocity.x = current_direction * speed
	else:
		velocity.x = 0 
