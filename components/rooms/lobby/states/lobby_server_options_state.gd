class_name LobbyServerOptionsState
extends State

@export_subgroup("Nodes")
@export var ServerOptions: VBoxContainer

func enter():
	ServerOptions.visible = true

func exit():
	ServerOptions.visible = false
