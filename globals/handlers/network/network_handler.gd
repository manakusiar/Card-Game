extends Node

const default_ip := "localhost"
const default_port := 25565
const default_max_clients := 2

signal connection_status_changed

enum CONNECTION_STATUSES {CONNECTED, FAILED, DISCONNECTED, STARTED}

var current_connection_status: CONNECTION_STATUSES = CONNECTION_STATUSES.DISCONNECTED
var peer: ENetMultiplayerPeer


#--- Engine Callback ---
func _ready() -> void:
	multiplayer.connected_to_server.connect(_connected_to_server)
	multiplayer.connection_failed.connect(_connection_to_server_failed)
	multiplayer.server_disconnected.connect(_disconnected_from_server)


#--- Server Connection and Establisment ---
func start_server(_port: int = default_port, _max_clients: int = default_max_clients) -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(_port, _max_clients)
	multiplayer.multiplayer_peer = peer
	_started_server()

func start_client(_ip_adress: String = default_ip, _port: int = default_port) -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(_ip_adress, _port)
	multiplayer.multiplayer_peer = peer


#--- Server Connection Callback ---
func _emit_connection_status_changed() -> void:
	connection_status_changed.emit(current_connection_status)

func _started_server() -> void:
	print("started server")
	current_connection_status = CONNECTION_STATUSES.STARTED
	_emit_connection_status_changed()

func _connected_to_server() -> void:
	print("connected")
	current_connection_status = CONNECTION_STATUSES.CONNECTED
	_emit_connection_status_changed()

func _connection_to_server_failed() -> void:
	current_connection_status = CONNECTION_STATUSES.FAILED
	_emit_connection_status_changed()

func _disconnected_from_server() -> void:
	print("disconnected")
	current_connection_status = CONNECTION_STATUSES.DISCONNECTED
	_emit_connection_status_changed()
