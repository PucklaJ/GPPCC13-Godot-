extends Node

var player
var coins = 0

func _input(event):
    if Input.is_action_just_pressed("toggle_fullscreen"):
        OS.window_fullscreen = !OS.window_fullscreen
    pass