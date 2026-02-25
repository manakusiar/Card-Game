class_name TitleJoinState
extends State

@export_subgroup("Nodes")
@export var JoinScreen: VBoxContainer
@export var JoinLabel: Label
@export var IpLineEdit: LineEdit

func enter():
	JoinScreen.visible = true

func exit():
	JoinScreen.visible = false

func _ready() -> void:
	multiplayer.connection_failed.connect(_on_connection_fail)

func _on_back_pressed() -> void:
	Transitioned.emit(self, "TitleMainState")

func _on_join_button_pressed() -> void:
	var _text = IpLineEdit.text
	var sep_ip = seperate_ip_and_port(_text)
	if sep_ip == [-1, -1]:
		JoinLabel.text = "Incorrect input!"
		return
	elif sep_ip[0] == "":
		sep_ip = ["localhost", "25565"]
	
	NetworkHandler.start_client(sep_ip[0],int(sep_ip[1]))
	
	JoinLabel.text = "Connecting to server..."
	await multiplayer.connected_to_server
	
	get_tree().change_scene_to_file("res://components/rooms/lobby/lobby.tscn")

func _on_connection_fail() -> void:
	JoinLabel.text = "Connection Failed!"

func seperate_ip_and_port(full_ip) -> Array:
	var parts = full_ip.split(":")
	if parts[0] == "": 
		return parts
	if len(parts) > 2 or len(parts) < 2:
		return [-1, -1]
	
	return parts
