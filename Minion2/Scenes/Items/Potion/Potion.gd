extends Area2D

func _ready():
	pass

func process():
	translate(Vector2(0, 2))

func _on_Potion_body_entered(body):
	if(body.get_meta("Type") == "Player"):
		body.revitalize(10)
		$AudioStreamPlayer.play()
		$CollisionShape2D.disabled = true
		$Sprite.visible = false

func _on_AudioStreamPlayer_finished():
	queue_free()
