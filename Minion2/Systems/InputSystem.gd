extends Node

func action_just_pressed(input):
	return Input.is_action_just_pressed(input)

func action_pressed(input):
	return Input.is_action_pressed(input)

func is_walking():
	return Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")

func not_walking():
	return (!is_walking())