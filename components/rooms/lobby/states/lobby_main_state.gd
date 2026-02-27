class_name LobbyMainState
extends State

@export_subgroup("Nodes")
@export var MainScreen: VBoxContainer
@export var ServerOptionsMain: VBoxContainer

func enter():
	MainScreen.visible = true
	ServerOptionsMain.visible = multiplayer.is_server()

func exit():
	MainScreen.visible = false


func _on_show_server_options_pressed() -> void:
	Transitioned.emit(self, "LobbyServerOptionsState")

func _on_show_client_options_pressed() -> void:
	Transitioned.emit(self, "LobbyClientOptionsState")
