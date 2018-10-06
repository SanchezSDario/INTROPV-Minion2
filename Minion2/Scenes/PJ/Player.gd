extends KinematicBody2D

signal hit
signal dead
var state_identifier
export (int) var life_points
export (int) var jump_force
export (int) var movement_speed
export (int) var JUMP_CONSTANT
var collision
var jump
var death = false

func _ready():
	set_meta("Type", "Player")

func _process(delta):
	StateSystem.update_state(self)
	if(!death):
		MovementSystem.execute(self)
		GravitySystem.apply(self, delta)
		CollisionSystem.execute(self)

func _on_DeathTimer_timeout():
	queue_free()
	print("You died")

func _on_RecoveryTimer_timeout():
	pass # replace with function body