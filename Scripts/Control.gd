extends Control

var tamanho_vidas = 20

func on_mudar_vidas_jogador(vida_jogador) -> void:
	$vidas.rect_size.x = vida_jogador * tamanho_vidas
	
