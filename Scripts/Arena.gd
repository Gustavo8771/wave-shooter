extends Node2D

export (Array, PackedScene) var inimigos
export (Array, PackedScene) var poderes

func _ready() -> void:
	Global.pontos = 0
	Global.criacao_no_pai = self

func _exit_tree() -> void:
	Global.criacao_no_pai = null


func _on_timer_spawn_inimigo_timeout() -> void:
	var posicao_inimigo = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	while posicao_inimigo.x < 640 and posicao_inimigo.x > -80 and posicao_inimigo.y < 360 and posicao_inimigo.y > -45:
		posicao_inimigo = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	var numero_inimigos = round(rand_range(0, inimigos.size() - 1))
	Global.instance_node(inimigos[numero_inimigos], posicao_inimigo, $Enemies)


func _on_timer_dificuldade_timeout() -> void:
	if $timer_spawn_inimigo.wait_time > 0.50:
		$timer_spawn_inimigo.wait_time -= 0.25


func _on_timer_spawn_poder_timeout() -> void:
	var posicao_poder = Vector2(rand_range(0, 640), rand_range(0, 320))
	
	var numero_poderes = round(rand_range(0, poderes.size() - 1))
	Global.instance_node(poderes[numero_poderes], posicao_poder, self)
