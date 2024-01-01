extends Node2D
class_name Main

@export var level_scenes: Array[PackedScene]
@export_group("Debug")
@export var debug_level_index: int = -1

var current_level_index: int = 0
var current_level: Level = null

@onready var restart_label: Label = $CanvasLayer/RestartLabel


func _ready():
	restart_label.visible = false
	if debug_level_index != -1:
		_start_level(debug_level_index)
	else:
		_start_level(current_level_index)
		
		
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit") and OS.get_name() != "Web":
		get_tree().quit()
		
	if Input.is_action_just_pressed("reset"):
		remove_child(current_level)
		current_level.queue_free()
		_start_level(current_level_index)
	
	
func _start_level(index: int) -> void:
	restart_label.visible = true
	current_level = level_scenes[index].instantiate() as Level
	add_child(current_level)
	current_level.connect("finished", _on_level_completed)
	
	
func _on_level_completed() -> void:
	current_level_index += 1
	remove_child(current_level)
	current_level.queue_free()
	if current_level_index >= level_scenes.size():
		print("Game Finished")
		return
		
	_start_level(current_level_index)
