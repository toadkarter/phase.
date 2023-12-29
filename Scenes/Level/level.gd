extends Node2D
class_name Level

@export var orbs: Array[Orb]

var is_in_first_world: bool = true

@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

func _ready():	
	if orbs.is_empty():
		print("Error: You forgot to add orbs to the level")
		
	for orb in orbs:
		if orb != null:
			orb.connect("changed_worlds", _on_changed_worlds)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _on_changed_worlds() -> void:
	if is_in_first_world:
		animation_player.play("start_second_world")
		is_in_first_world = false
	else:
		animation_player.play_backwards()
		is_in_first_world = true
	
