extends Node2D
class_name Level

signal finished

const LEVEL_DISPLACEMENT: float = 256.0

@export var orbs: Array[Orb]
@export var player_scene: PackedScene
@export var door: Door
@export var first_world: Node2D
@export var second_world: Node2D
@export var player_spawn: Node2D

var is_in_first_world: bool = true
var first_world_objects: Array[Node2D]
var second_world_objects: Array[Node2D]

@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
@onready var world_fade: AnimationPlayer = $CanvasLayer/WorldFade
@onready var world_fade_animation_length: float = animation_player.get_animation("start_second_world").length

func _ready():	
	second_world.modulate.a = 1.0
	second_world.position.y -= LEVEL_DISPLACEMENT
	
	_init_objects()
	_init_orbs()
	_init_player()
	
	door.connect("entered", _on_door_entered)
	world_fade.play("fade_in")
	
func _on_changed_worlds() -> void:
	if is_in_first_world:
		animation_player.play("start_second_world")
		await get_tree().create_timer(world_fade_animation_length).timeout
		_setup_second_world()
	else:
		animation_player.play_backwards()
		await get_tree().create_timer(world_fade_animation_length).timeout
		_setup_first_world()
		
		
func _init_objects() -> void:
	for object in get_children():
		if object.is_in_group("Phaseable"):
			print("Error: Object " + object.name + " is phaseable but not affixed to a world node.")
	
	for first_world_object in first_world.get_children():
		if first_world_object.is_in_group("Phaseable"):
			first_world_objects.append(first_world_object)
			
	for second_world_object in second_world.get_children():
		if second_world_object.is_in_group("Phaseable"):
			second_world_objects.append(second_world_object)	
			
			
func _setup_first_world() -> void:
	for first_world_object in first_world_objects:
		first_world_object.position.y += LEVEL_DISPLACEMENT
	for second_world_object in second_world_objects:
		second_world_object.position.y -= LEVEL_DISPLACEMENT
	for orb in orbs:
		if orb.is_in_first_world():
			orb.position.y += LEVEL_DISPLACEMENT
		else:
			orb.position.y -= LEVEL_DISPLACEMENT
	
	is_in_first_world = true
			
			
func _setup_second_world() -> void:
	for first_world_object in first_world_objects:
		first_world_object.position.y -= LEVEL_DISPLACEMENT
	for second_world_object in second_world_objects:
		second_world_object.position.y += LEVEL_DISPLACEMENT
	for orb in orbs:
		if orb.is_in_first_world():
			orb.position.y -= LEVEL_DISPLACEMENT
		else:
			orb.position.y += LEVEL_DISPLACEMENT
	
	is_in_first_world = false


func _init_orbs() -> void:
	if orbs.is_empty():
		print("Error: You forgot to add orbs to the level")
		
	for orb in orbs:
		if orb != null:
			orb.connect("changed_worlds", _on_changed_worlds)
	
	
func _init_player() -> void:
	var player = player_scene.instantiate()
	add_child(player)
	player.position = player_spawn.position
	

func _on_door_entered() -> void:
	var length = world_fade.get_animation("fade_in").length
	world_fade.play_backwards("fade_in")
	animation_player.play_backwards()
	await get_tree().create_timer(length).timeout
	finished.emit()
