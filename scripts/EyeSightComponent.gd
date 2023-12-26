extends RayCast2D

func check_if_visible(body: PhysicsBody2D) -> bool:
	target_position = body.global_position - global_position
	force_raycast_update()
	return !is_colliding()
