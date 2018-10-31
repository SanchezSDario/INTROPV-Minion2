extends Area2D

func _ready():
	pass

func _on_Diamante_body_entered(body):
	if(body.get_meta("Type") == "Player"):
		body.add_diamond()
		$AudioStreamPlayer.play()
		$CollisionShape2D.disabled = false
		$Sprite.visible = false

func _on_AudioStreamPlayer_finished():
	queue_free()
