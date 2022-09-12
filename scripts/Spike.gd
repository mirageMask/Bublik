extends Area2D


func _on_Spike_body_entered(_body:Node):
	Signals.emit_signal("damaged",_body)

