extends Node

var player
var coins = 0 setget set_coins
onready var collected_coin_distance_curve = load("res://misc/CollectedCoinDistance.tres")

func _input(event):
    if Input.is_action_just_pressed("toggle_fullscreen"):
        OS.window_fullscreen = !OS.window_fullscreen
    pass

func set_coins(new_value):
    coins = new_value
    player.get_node("HUD/CollectedCoins").new_collected_coin()
    pass