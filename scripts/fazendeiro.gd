extends CharacterBody2D

@onready var movement_validation : RayCast2D = $FMovementValidation
@onready var movement_tween : Node = $FMovementTween
@onready var sprite_2d : AnimatedSprite2D = $Sprite2D
@onready var sensor : Area2D = $SensorComponent
@onready var eye_sight : RayCast2D = $EyeSightComponent

@export var grid_size : int = 48

var vectors : PackedVector2Array = [Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1)]
var valid_directions : Array = []
var old_position : Vector2


func _ready() -> void:
	sensor.set_groups(get_groups())


func validate_directions() -> void:
	for vector in vectors:
		if movement_validation.validate_movement(vector * grid_size):
			valid_directions.append(vector)
	valid_directions.erase(old_position)


func tween_it(movement_direction : Vector2) -> void:
	old_position = -movement_direction
	movement_tween.run(self, movement_direction)
	movement_tween.tween.finished.connect(on_movement_tween_finished)
	valid_directions.clear()


func wander() -> void:
	validate_directions()
	var direction : Vector2 = valid_directions[randi_range(0, valid_directions.size()-1)]
	old_position = -direction
	
	var movement_direction = global_position + direction * grid_size
	
	tween_it(movement_direction)
	
	if (direction.x == 0):
		return
	
	var isRight = direction.x < 0
	sprite_2d.flip_h = isRight
	


func move_towards(target : PhysicsBody2D) -> void:
	validate_directions()
	var max_distance : float = INF
	var movement_direction : Vector2
	for direction in valid_directions:
		direction = direction * grid_size + global_position
		var distance = direction.distance_to(target.global_position)
		if distance < max_distance:
			max_distance = distance
			movement_direction = direction
		else:
			continue
	tween_it(movement_direction)


func on_movement_tween_finished() -> void:
	pass #Same as with player process everything that should happen once movement is finished


func on_start_move() -> void:
	if sensor.check_area():
		var target : PhysicsBody2D = sensor.return_bodies()[0]
		if !eye_sight.check_if_visible(target):
			move_towards(target)
		else:
			wander()
	else:
		wander()

