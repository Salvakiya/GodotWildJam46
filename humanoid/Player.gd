extends Node2D

signal expression(what)

func setup(parent:KinematicBody2D):
	parent.controller = self
	parent.is_player = true

func get_input():
	var input = Vector2(
		(1 if Input.is_action_pressed("move_right") else 0)-(1 if Input.is_action_pressed("move_left") else 0),
		(1 if Input.is_action_pressed("move_down") else 0)-(1 if Input.is_action_pressed("move_up") else 0)
	)
	return input

func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		pass
