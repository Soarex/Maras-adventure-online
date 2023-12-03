extends Node

const PORT = 4433

func _ready():
	get_tree().paused = true
	multiplayer.server_relay = false

	if DisplayServer.get_name() == "headless":
		print("Automatically starting dedicated server.")
		_on_host_button_pressed.call_deferred()
		
		
func change_level(scene: PackedScene):
	var level = $Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()

	level.add_child(scene.instantiate())


func _on_host_button_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
		
	multiplayer.multiplayer_peer = peer
	start_game()
	

func _on_connect_button_pressed():
	var txt : String = $MultiplayerConnectMenu/MultiplayerConnectUI/VBoxContainer/HBoxContainer/IPField.text
	if txt == "":
		OS.alert("Need a remote to connect to.")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(txt, PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()


func start_game():
	$MultiplayerConnectMenu.hide()
	get_tree().paused = false
	
	if multiplayer.is_server():
		change_level.call_deferred(load("res://scenes/splat_level.tscn"))

