extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Player_lives_count(lives):
	text = (str(lives))
