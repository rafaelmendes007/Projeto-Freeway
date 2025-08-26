extends Node

var cenas_carros = preload("res://Cenas/carros.tscn");
var pistas_rapidas_y = [104, 272, 488]; # Possui uma distância de 56 pra cada
var pistas_lentas_y = [160, 216, 324, 384, 438, 544, 600];
var score = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Placar.text = str(score);
	$HUD/Mensagem.text = " ";
	$HUD/Button.hide();
	$AudioTema.play();
	randomize();

func _on_timer_carros_rapidos_timeout() -> void:
	var carro = cenas_carros.instantiate();
	add_child(carro);
	var pista_y = pistas_rapidas_y[randi_range(0, pistas_rapidas_y.size() - 1)]; # Usar o .size para o tamanho do vetor
	carro.position = Vector2(-10, pista_y);
	carro.set_linear_velocity(Vector2(randi_range(700, 720), 0));
	carro.set_linear_damp(0.0);


func _on_timer_carros_lentos_timeout() -> void:
	var carro = cenas_carros.instantiate();
	add_child(carro);
	var pista_y = pistas_lentas_y[randi_range(0, pistas_lentas_y.size() - 1)]; # Usar o .size para o tamanho do vetor
	carro.position = Vector2(-10, pista_y);
	carro.set_linear_velocity(Vector2(randi_range(300, 320), 0));
	carro.set_linear_damp(0.0);


func _on_player_pontua() -> void:
	if score <= 10:
		score += 1;
		$HUD/Placar.text = str(score);
		$AudioPonto.play();
		$Player.position = $Player.posicao_inicial;
	if score == 10:
		$HUD/Mensagem.show();
		$HUD/Button.show();
		$TimerCarrosRapidos.stop();
		$TimerCarrosLentos.stop();
		$AudioVitoria.play();
		$Player.speed = 0;
func _on_reinicia() -> void:
	get_tree().reload_current_scene();
