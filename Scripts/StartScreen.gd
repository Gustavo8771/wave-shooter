extends Control

func _on_botaoIniciar_pressed() -> void:
	if get_tree().change_scene("res://Arena.tscn") != OK:
		print("Algo deu errado!")

func _on_botaoCrditos_pressed() -> void:
	if get_tree().change_scene("res://CreditsScreen.tscn") != OK:
		print("Algo deu errado!")
