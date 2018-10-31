extends CanvasLayer

func _ready():
	pass

func _process(delta):
	if(get_parent().has_node("Player")):
		$LifeLabel.set_text(get_parent().get_node("Player").life_points)
		$DiamondLabel.set_text(get_parent().get_node("Player").diamonds)