extends RigidBody2D
@onready var sprite = $Animacao;

func _ready() -> void:
	var tipos_carros = $Animacao.sprite_frames.get_animation_names();
	var carro = tipos_carros[randi_range(0, tipos_carros.size() - 1)];
	$Animacao.animation = carro;
	$Animacao.play()


func _on_notificador_screen_exited() -> void:
	queue_free();

func setup(velocidade: Vector2, pos_inicial: Vector2):
	print("------------------")
	print("Setup chamado! Velocidade: ", velocidade) # Isso mostra se a função está sendo chamada

	# Define a velocidade e a posição
	self.position = pos_inicial
	self.linear_velocity = velocidade
	self.linear_damp = 0.0
	
	print("O nó de sprite é: ", sprite) # Isso nos diz se a referência $Animacao funcionou

	# A própria cobra decide se deve inverter seu sprite
	if velocidade.x < 0:
		print("Flip DEVE acontecer!") # Mostra se a condição para virar foi atingida
		sprite.flip_h = true
	else:
		print("Flip NÃO deve acontecer.")
		sprite.flip_h = false
