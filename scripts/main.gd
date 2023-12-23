extends Node2D

func _draw():
	for x in range(0, 1152, 48):
		draw_line(Vector2(x, 0), Vector2(x, 672), Color8(255, 0, 0), 1.5)
	for y in range(0, 672, 48):
		draw_line(Vector2(0, y), Vector2(1152, y), Color8(255, 0, 0), 2)
