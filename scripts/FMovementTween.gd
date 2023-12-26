extends Node

@export var move_time : float = 0.0

@export_enum("TRANS_LINEAR", "TRANS_SINE", "TRANS_QUINT", "TRANS_QUART", "TRANS_QUAD", "TRANS_EXPO", "TRANS_ELASTIC", "TRANS_CUBIC", "TRANS_CIRC", "TRANS_BOUNCE", "TRANS_BACK") var transition : int

@export_enum("TRANS_LINEAR", "TRANS_SINE", "TRANS_QUINT", "TRANS_QUART", "TRANS_QUAD", "TRANS_EXPO", "TRANS_ELASTIC", "TRANS_CUBIC", "TRANS_CIRC", "TRANS_BOUNCE", "TRANS_BACK") var easing : int

var tween = Tween

func run(body : CharacterBody2D, end_position : Vector2) -> void:
	tween = get_tree().create_tween().bind_node(self)
	tween.set_trans(transition)
	tween.set_ease(easing)
	tween.tween_property(body, "global_position", end_position, move_time)
