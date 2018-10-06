extends Timer

func _ready():
	pass

func _on_Player_hit():
	var player = get_parent().get_node("Player")
	player.get_node("AnimatedSprite").frames.set_animation_loop("Hit",false)
	player.get_node("AnimatedSprite").frames.set_animation_speed("Hit",7)
	player.get_node("AnimatedSprite").play("Hit")     
#	player.get_node("CollisionShape2D").disabled = true