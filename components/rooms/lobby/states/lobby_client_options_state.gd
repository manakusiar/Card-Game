class_name LobbyClientOptionsState
extends State

@export_subgroup("Nodes")
@export var ClientOptions: VBoxContainer

func enter():
	ClientOptions.visible = true

func exit():
	ClientOptions.visible = false
