extends CanvasLayer

func _ready() -> void:
	mostrar(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and Global.is_playing:
		get_tree().paused = !get_tree().paused
		mostrar(get_tree().paused)

func mostrar(is_visible) -> void:
	for node in get_children():
		node.visible = is_visible

func _on_botaoContinuar_pressed() -> void:
	mostrar(false)
	get_tree().paused = false
