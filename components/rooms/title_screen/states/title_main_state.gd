class_name TitleMainState
extends State

@export_subgroup("Nodes")
@export var MainScreen: VBoxContainer

func enter():
	MainScreen.visible = true

func exit():
	MainScreen.visible = false

func _on_start_server_pressed() -> void:
	Transitioned.emit(self, "TitleHostState")

func _on_start_client_pressed() -> void:
	Transitioned.emit(self, "TitleJoinState")
