extends CharacterBody2D

@onready var movement_validation : RayCast2D = $EMovementValidation
@onready var movement_tween : Node = $EMovementTween
@onready var sprite_2d : AnimatedSprite2D = $Sprite2D


@export var grid_size : int = 48

var vectors : PackedVector2Array = [Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1)]
var valid_directions : Array = []
var old_position : Vector2


func wander() -> void:
	for vector in vectors:
		if movement_validation.validate_movement(vector * grid_size):
			valid_directions.append(vector)


	#valid_directions.erase(old_position) #Entender melhor depos <-

	var direction : Vector2 = valid_directions[randi_range(0,valid_directions.size()-1)]

	old_position = -direction
	
	movement_tween.run(self,global_position + direction * grid_size)
	movement_tween.tween.finished.connect(on_movement_tween_finished)
	
	
	valid_directions.clear()
	
	
	if (direction.x == 0):
		return
	
	var isRight = direction.x < 0
	sprite_2d.flip_h = isRight



func on_movement_tween_finished() -> void:
	pass #Same as with player process everything that should happen once movement is finished


func on_start_move() -> void:
	wander()
