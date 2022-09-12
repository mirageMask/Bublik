extends CanvasLayer
onready var button := $Button
func _ready()->void:
	button.connect('pressed',Signals,'emit_signal',['game_started'])
	Signals.connect('game_started',self,'visibility')
	Signals.connect('lives_count',self,'print_lives')


func print_lives(lives): $Lives.text = str(lives)

func visibility()->void:
	$Lives/TextureRect.visible = true
	button.visible = false
	# visible = false
