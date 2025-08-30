extends CanvasLayer;

signal reinicia;

func _on_button_pressed() -> void:
	emit_signal("reinicia");
	
func atualizar_tempo(tempo):
	$TempoRestante.text = "Tempo: " + str(tempo)
