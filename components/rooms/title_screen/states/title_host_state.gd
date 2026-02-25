class_name TitleHostState
extends State

@export_subgroup("Nodes")
@export var HostScreen: VBoxContainer
@export var PlayerCountLabel: Label
@export var PlayerCountSlider: HSlider
@export var PortLineEdit: LineEdit

func enter():
	HostScreen.visible = true

func exit():
	HostScreen.visible = false


func _on_back_pressed() -> void:
	Transitioned.emit(self, "TitleMainState")

func _on_h_slider_value_changed(value: float) -> void:
	PlayerCountLabel.text = "Player Count: " + str(int(ceil(value)))

func _on_host_button_pressed() -> void:
	var _port = PortLineEdit.text
	var _player_count = int(PlayerCountSlider.value)
	if _port == "": _port = "25565"
	
	NetworkHandler.start_server(int(_port), _player_count)
	get_tree().change_scene_to_file("res://components/rooms/lobby/lobby.tscn")
