extends Node2D

@export var connection_status_label: Label

func _ready() -> void:
	NetworkHandler.connection_status_changed.connect(network_connection_status_changed)
	PlayerHandler.players_updated.connect(player_joined)

func network_connection_status_changed(new_status) -> void:
	var _s = NetworkHandler.CONNECTION_STATUSES
	if _s.CONNECTED == new_status:
			connection_status_label.text = "Connected successfully!"
	elif _s.FAILED == new_status:
			connection_status_label.text = "Connection Failed ;3"
	elif _s.DISCONNECTED == new_status:
			connection_status_label.text = "Disconnected from server."

func player_joined(peer_id: int, disconnected: bool) -> void:
	if disconnected: 
		connection_status_label.text = "Player " + str(PlayerHandler.get_player_index(peer_id)) + " - " + str(peer_id) + " disconnected the server!"
	else:
		connection_status_label.text = "Player " + str(PlayerHandler.get_player_index(peer_id)) + " - " + str(peer_id) + " joined the server!"
