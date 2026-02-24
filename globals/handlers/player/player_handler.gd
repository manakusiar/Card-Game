extends Node

var players := []

func _ready() -> void:
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)

func _peer_connected(peer: int) -> void:
	players.append(peer)

func _peer_disconnected(peer: int) -> void:
	var _peer_index = players.find(peer)
	if _peer_index != -1:
		players.pop_at(players.find(peer))
	else:
		push_error("Attempting to remove player that is not found in array.")
