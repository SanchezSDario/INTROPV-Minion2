extends Timer

func _ready():
	pass

func _on_Player_hit():
	start()
	var player = get_parent().get_node("Player")
	player.get_node("AnimatedSprite").play("Hit")     
	player.get_node("CollisionShape2D").disabled = true
	player.get_node("FloorCollision").disabled = true