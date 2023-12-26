extends CharacterBody2D

signal start_move

@onready var movement_validation : RayCast2D = $MovementValidation
@onready var movement_tween : Node = $MovementTween
@onready var sprite_2d : AnimatedSprite2D = $Sprite2D

@export var grid_size : int = 48

var direction : Vector2 = Vector2.ZERO
var can_move : bool = true

var enemy_in_range : bool = false
var enemy_atck_cooldown : bool = true
var health : int = 100
var player_alive : bool = true


func _process(_delta : float) -> void:
	if (Input.is_action_pressed("up")):
		sprite_2d.animation = "idle_back"
	elif (Input.is_action_pressed("down")):
		sprite_2d.animation = "idle"
	
	
	direction.x = -int(Input.is_action_just_pressed("left")) + int(Input.is_action_just_pressed("right"))
	direction.y = -int(Input.is_action_just_pressed("up")) + int(Input.is_action_just_pressed("down"))
	
	if (direction.x == 0):
		return
	
	var isRight = direction.x > 0
	sprite_2d.flip_h = isRight


func _physics_process(_delta : float) -> void:
	if movement_validation.validade_movement(direction * grid_size) and can_move and direction != Vector2.ZERO:
		can_move = false
		emit_signal("start_move")
		movement_tween.run(self, global_position + direction * grid_size)
		movement_tween.tween.finished.connect(on_movement_tween_finished)
		
	if health <= 0:
		player_alive = false # !!!!! RESETAR DAQUI
		get_tree().reload_current_scene()



func on_movement_tween_finished() -> void:
	can_move = true



func _on_player_hitbox_body_entered(body):
	if body.is_in_group("Enemies"):
		enemy_in_range = true
		enemy_atack()


func _on_player_hitbox_body_exited(body):
	if body.is_in_group("Enemies"):
		enemy_in_range = false


func enemy_atack():
	if enemy_in_range and enemy_atck_cooldown == true:
		health = health - 5
		enemy_atck_cooldown = false
		$attack_cooldown.start()


func _on_attack_cooldown_timeout():
	enemy_atck_cooldown = true
