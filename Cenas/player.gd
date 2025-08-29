extends Area2D;

signal pontua;
signal pontua2;

# variável para identificar o jogador
@export var player_id: int = 1;
var speed: float = 300.0;
var screen_size: Vector2;
var posicao_inicial_p1: Vector2 = Vector2(840, 685);
var posicao_inicial_p2: Vector2 = Vector2(440, 685);

# função para fazer o player retornar à posição inicial
func _ready():
	screen_size = get_viewport_rect().size;
	if player_id == 1:
		position = posicao_inicial_p1;
	if player_id == 2:
		position = posicao_inicial_p2;

func _process(delta):
	var velocity = Vector2.ZERO;
	
	if player_id == 1:
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1;
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1;
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1;
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1;
	
	if player_id == 2:
		if Input.is_action_pressed("p2_up"):
			velocity.y -= 1;
		if Input.is_action_pressed("p2_down"):
			velocity.y += 1;
		if Input.is_action_pressed("p2_right"):
			velocity.x += 1;
		if Input.is_action_pressed("p2_left"):
			velocity.x -= 1;
	
	
	if velocity !=Vector2.ZERO:
		velocity = velocity.normalized() * speed;
	
	position += velocity * delta;
	position.y = clamp(position.y, 0.0, screen_size.y);

	if velocity.y > 0:
		$Animacao.play("baixo");
	elif velocity.y < 0:
		$Animacao.play("cima");
	else:
		$Animacao.stop();
	

func _on_body_entered(body: Node2D) -> void:
	if body.name == "LinhaChegada":
		if player_id == 1:
			emit_signal("pontua");
		if player_id == 2:
			emit_signal("pontua2");
	else:
		$Audio.play();
		if player_id == 1:
			position = posicao_inicial_p1;
		if player_id ==  2:
			position = posicao_inicial_p2;
