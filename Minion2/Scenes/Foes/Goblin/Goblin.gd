extends Node2D

export (int) var gravity
export (int) var movement_speed
export (int) var jump_force
export (int) var JUMP_CONSTANT
var collision
var jump

func _ready():
	movement_speed = 0
	set_meta("Type", "Enemy")
	$AnimatedSprite.play("Idle")

func _process(delta):
	MovementSystem.execute(self)
	GravitySystem.apply(self, delta)
	CollisionSystem.execute(self)

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	movement_speed = 1.5
	$AnimatedSprite.play("Walk")

func attack(): return 5