extends CharacterBody2D

@export var speed: float = 300.0


func _physics_process(delta):
	var horizontal_direction = Input.get_axis("left", "right")
	var vertical_direction = Input.get_axis("up", "down")
	
	if vertical_direction:
		velocity.y = vertical_direction * speed
	else:
		velocity.y = 0
	
	if horizontal_direction:
		velocity.x = horizontal_direction * speed
	else:
		velocity.x = 0

	move_and_slide()
	

func _handle_vertical_movement(current_direction: float) -> void:
	if current_direction:
		velocity.y = current_direction * speed
	else:
		velocity.y = 0
		
		
func _handle_horizontal_movement(current_direction: float) -> void:
	if current_direction:
		velocity.x = current_direction * speed
	else:
		velocity.x = 0 
