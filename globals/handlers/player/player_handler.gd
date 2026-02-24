extends Node

signal players_updated

var players := [1]


# --- Engine Callback ---
func _ready() -> void:
	NetworkHandler.connection_status_changed.connect(_connected_to_server)


# --- Connection Status ---
func _connected_to_server(status) -> void:
	var _s = NetworkHandler.CONNECTION_STATUSES
	print("Server: " + str(multiplayer.get_unique_id()))
	
	if status == _s.STARTED:
		print("Started server: " + str(multiplayer.get_unique_id()))
		if multiplayer.is_server():
			multiplayer.peer_connected.connect(_peer_connected.rpc)
			multiplayer.peer_disconnected.connect(_peer_disconnected.rpc)

@rpc("call_local")
func _peer_connected(peer: int) -> void:
	players.append(peer)
	print("PEER connected: " + str(players) + " - " + str(multiplayer.get_unique_id()))
	_emit_new_player_signal(peer)

@rpc("call_local")
func _peer_disconnected(peer: int) -> void:
	var _peer_index = players.find(peer)
	if _peer_index != -1:
		players.pop_at(players.find(peer))
	else:
		push_error("ERROR: Attempting to remove player that is not found in array.")
	
	print("PEER disconnected: " + str(peer) + " - " + str(multiplayer.get_unique_id()))
	_emit_new_player_signal(peer, true)

func _emit_new_player_signal(peer: int, disconnected: bool = false):
	players_updated.emit(peer, disconnected)


# --- Getter Functions ---
func get_player_index(player_id: int) -> int:
	return players.find(player_id)

func get_player_id(player_index: int) -> int:
	if len(players) > player_index and player_index > 0: return -1
	return players[player_index]
