extends Node

export (int) var gravity
var potion_scene = load("res://Scenes/Items/Potion/Potion.tscn")
var diamond_scene = load("res://Scenes/Items/Diamond/Diamante.tscn")

func _ready():
	randomize()

func _on_Player_dead():
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	$Player.queue_free()
	print("You died")

func drop_potion(position):
	var potion = potion_scene.instance()
	add_child(potion)
	potion.position = position

func drop_diamond(position):
	var diamond = diamond_scene.instance()
	add_child(diamond)
	diamond.position = position