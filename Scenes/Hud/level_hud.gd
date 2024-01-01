extends CanvasLayer
class_name Hud


@onready var world_filter: ColorRect = $WorldFilter
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var world_fade: AnimationPlayer = $WorldFade


func _ready() -> void:
	world_filter.modulate.a = 0.0


func fade_in() -> void:
	world_fade.play("fade_in")


func fade_out() -> void:
	world_fade.play_backwards()


func start_second_world() -> void:
	animation_player.play("start_second_world")


func start_first_world() -> void:
	animation_player.play_backwards()


func get_world_fade_animation_length() -> float:
	return animation_player.get_animation("start_second_world").length


func get_level_start_animation_length() -> float:
	return world_fade.get_animation("fade_in").length
