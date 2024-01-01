extends Node2D
class_name Intro

signal finished

var starting_game: bool = false

@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
@onready var player: Player = $Player 
@onready var hud: CanvasLayer = $CanvasLayer


func _ready():
	animation_player.play("fade_carousel")


func _process(_delta):
	if starting_game:
		return
	if Input.is_anything_pressed():
		starting_game = true
		_play_starting_game_animation()
		
		
func _play_starting_game_animation() -> void:
	hud.visible = false
	var length: float = animation_player.get_animation("intro_animation").length
	animation_player.play("intro_animation")
	await get_tree().create_timer(length).timeout
	finished.emit()
