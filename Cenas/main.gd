extends Node

var cenas_carros = preload("res://Cenas/carros.tscn");
var pistas_rapidas_y = [104, 272, 488]; # Possui uma distância de 56 pra cada
var pistas_lentas_y = [160, 216, 324, 384, 438, 544, 600];
var score = 0;
var score2 = 0


# Pistas para carros rápidos e lentos com sentido
var pistas_rapidas_esq_dir = [104, 272];
var pistas_rapidas_dir_esq = [488];
var pistas_lentas_esq_dir = [216, 384, 600];
var pistas_lentas_dir_esq = [160, 324, 438, 544];

# Sinal para a HUD
signal tempo_restante(tempo);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Placar.text = str(score);
	$HUD/Placar2.text = str(score2);
	$HUD/MensagemVitoria.hide();
	$HUD/MensagemDerrota.hide();
	$HUD/Button.hide();
	$AudioTema.play();
	randomize();
	$TimerGameOver.start();

func _process(delta):
	if $TimerGameOver.time_left > 0:
		emit_signal("tempo_restante", int($TimerGameOver.time_left));

func _on_timer_carros_rapidos_timeout() -> void:
	var carro = cenas_carros.instantiate();
	add_child(carro);
	
	# Variável da direção iniciando em 1
	var direcao;
	if randi() % 2 != 0:
		direcao = 1; # esquerda pra direita
	else:
		direcao = -1; # direita pra esquerda
		
	var pista_y: int;
	var start_x: int;
	var velocidade = randi_range(700, 720);
	
	# Condicionando a pista, ponto de partida e velocidade a partir da direcao
	if direcao == 1:
		pista_y = pistas_rapidas_esq_dir[randi_range(0, pistas_rapidas_esq_dir.size() - 1)];
		start_x = -10;
	else:
		pista_y = pistas_rapidas_dir_esq[randi_range(0, pistas_rapidas_dir_esq.size() - 1)];
		start_x = 1290;
		velocidade *= -1;
	
	carro.position = Vector2(start_x, pista_y);
	carro.set_linear_velocity(Vector2(velocidade, 0));
	carro.set_linear_damp(0.0);


func _on_timer_carros_lentos_timeout() -> void:
	var carro = cenas_carros.instantiate();
	add_child(carro);
	
	# Variável da direção iniciando em 1
	var direcao;
	if randi() % 2 != 0:
		direcao = 1; # esquerda pra direita
	else:
		direcao = -1; # direita pra esquerda
		
	var pista_y: int;
	var start_x: int;
	var velocidade = randi_range(300, 320);
	
	# Condicionando a pista, ponto de partida e velocidade a partir da direcao
	if direcao == 1:
		pista_y = pistas_lentas_esq_dir[randi_range(0, pistas_lentas_esq_dir.size() - 1)];
		start_x = -10;
	else:
		pista_y = pistas_lentas_dir_esq[randi_range(0, pistas_lentas_dir_esq.size() - 1)];
		start_x = 1290;
		velocidade *= -1;
	
	carro.position = Vector2(start_x, pista_y);
	carro.set_linear_velocity(Vector2(velocidade, 0));
	carro.set_linear_damp(0.0);

# CRIAR UMA MENSAGEM PRA CADA PLAYER
func _on_player_pontua() -> void:
	if score <= 10:
		score += 1;
		$HUD/Placar.text = str(score);
		$AudioPonto.play();
		$Player.position = $Player.posicao_inicial_p1;
	if score >= 2:
		$TimerGameOver.stop();
		$HUD/MensagemVitoria.show();
		$HUD/Button.show();
		$TimerCarrosRapidos.stop();
		$TimerCarrosLentos.stop();
		$AudioVitoria.play();
		$Player.speed = 0;
		$Player2.speed = 0;
		
func _on_player_2_pontua_2() -> void:
	if score2 <= 10:
		score2 += 1;
		$HUD/Placar2.text = str(score2);
		$AudioPonto.play();
		$Player2.position = $Player2.posicao_inicial_p2;
	if score2 >= 2:
		$TimerGameOver.stop();
		$HUD/MensagemVitoria.show();
		$HUD/Button.show();
		$TimerCarrosRapidos.stop();
		$TimerCarrosLentos.stop();
		$AudioVitoria.play();
		$Player2.speed = 0;
		$Player.speed = 0;

func _on_timer_game_over_timeout() -> void:
	$TimerGameOver.stop();
	$HUD/MensagemDerrota.show();
	$HUD/Button.show();
	$TimerCarrosRapidos.stop();
	$TimerCarrosLentos.stop();
	$AudioTema.stop();
	# CRIAR AUDIO DERROTA
	$Player2.speed = 0;
	$Player.speed = 0;

func _on_hud_reinicia() -> void:
	get_tree().reload_current_scene();
