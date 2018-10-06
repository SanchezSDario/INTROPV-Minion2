extends Node

export (int) var gravity

func _ready():
	randomize()

func _on_Player_dead():
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	$Player.queue_free()
	print("You died")