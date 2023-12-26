extends Area2D


var groups: Array
var detected: Array


func _on_body_entered(body):
	for group in groups:
		if !body.is_in_group(group) and !detected.has(body) and body is CharacterBody2D:
			detected.append(body)
			print(detected)


func _on_body_exited(body):
	if detected.has(body):
		detected.erase(body)


func set_groups(groups_array: Array) -> void:
	groups = groups_array
	print(groups)


func check_area() -> bool:
	return !detected.is_empty()


func return_bodies() -> Array:
	return detected

