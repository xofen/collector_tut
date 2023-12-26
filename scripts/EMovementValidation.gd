extends RayCast2D

func validate_movement(cast_to : Vector2) -> bool:
	target_position = cast_to
	force_raycast_update()
	return !is_colliding()
