extends CharacterBody2D

@onready var movement_validation : RayCast2D = $MovementValidation
@onready var movement_tween : Node = $MovementTween
@onready var sprite_2d : AnimatedSprite2D = $Sprite2D

@export var grid_size : int = 48

var direction : Vector2 = Vector2.ZERO
var can_move : bool = true


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
		movement_tween.run(self, global_position + direction * grid_size)
		movement_tween.tween.finished.connect(on_movement_tween_finished)


func on_movement_tween_finished() -> void:
	can_move = true

