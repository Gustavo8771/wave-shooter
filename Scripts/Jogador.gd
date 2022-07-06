extends Sprite


signal mudarVidas(vida_jogador)
var velocidade = 150
var mov = Vector2.ZERO

const projetil = preload("res://projetil.tscn")

var recarregado = true

var tempo_recarga = 0.1
var padrao_tempo_recarga = tempo_recarga

var dano = 1
var dano_padrao = dano

var reset_poder = []

var max_vidas = 3
var vidas = max_vidas

var morto = false

func _ready() -> void:
	Global.is_playing = true
	Global.jogador = self
	if connect("mudarVidas", get_parent().get_node("UI/Control"), "on_mudar_vidas_jogador") != OK:
		print("Algo deu errado!")
	emit_signal("mudarVidas", max_vidas)
	Global.textura_dano = get_parent().get_node("UI/Control/textura_dano")

func _exit_tree() -> void:
	Global.is_playing = false
	Global.jogador = null

func _process(delta: float) -> void:
	mov.x = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
	mov.y = int(Input.is_action_pressed("baixo")) - int(Input.is_action_pressed("cima"))
	
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	if !morto:
		global_position += velocidade * mov * delta
	
	if Input.is_action_pressed("atirar") and Global.criacao_no_pai != null and recarregado and !morto:
		var instancia_projetil = Global.instance_node(projetil, global_position, Global.criacao_no_pai)
		instancia_projetil.dano = dano
		recarregado = false
		$tempo_recarga.start()
	
	look_at(get_global_mouse_position())

func _on_tempo_recarga_timeout() -> void:
	recarregado = true
	$tempo_recarga.wait_time = tempo_recarga

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("inimigo"):
		vidas -= 1
		emit_signal("mudarVidas", vidas)
		Global.textura_dano.show()
		$tempo_tela_dano.start()
		
	if vidas <= 0:
		visible = false
		morto = true
		Global.matar_inimigos()
		$tempo_morte.start()

func _on_tempo_morte_timeout() -> void:
	$hitbox.queue_free()
	if get_tree().reload_current_scene() != OK:
		print("Algo deu errado!")
	Global.salvar_jogo()

func _on_tempo_recarga_cooldown_timeout() -> void:
	if reset_poder.find("tempo_recarga") != null:
		tempo_recarga = padrao_tempo_recarga
		reset_poder.erase("tempo_recarga")
	
	if reset_poder.find("dano") != null:
		dano = dano_padrao
		reset_poder.erase("dano")
	
	modulate = Color("286bd2")

func _on_tempo_tela_dano_timeout() -> void:
	Global.textura_dano.hide()
