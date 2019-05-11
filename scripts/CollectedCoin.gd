extends Sprite

export var MOVE_TIME = 2.0

var coin_num
var is_collecting = false
var dest
var direction = Vector2(0,0)
var time = 0
var MAX_DISTANCE

onready var coin_symbol = get_node("../../Coins/HBoxContainer/CoinSymbol")
onready var wsize = OS.get_real_window_size()
onready var collected_coin_distance_curve = load("res://misc/CollectedCoinDistance.tres")

func _ready():
    dest = coin_symbol.rect_global_position + coin_symbol.rect_size/2
    direction = (dest-wsize/2).normalized()
    MAX_DISTANCE = dest.distance_to(wsize/2)
    pass

func _process(delta):
    if is_collecting:
        move_and_die(delta)
    else:
        position = wsize/2

    visible = is_collecting
        
    pass

func move_and_die(delta):
    time += delta

    var dist_val = collected_coin_distance_curve.interpolate(time/MOVE_TIME)
    position = wsize/2+direction*MAX_DISTANCE*dist_val
    if time  > MOVE_TIME:
        is_collecting = false
        var text = globals.player.get_node("HUD/Coins/HBoxContainer/CoinText")
        text.text = String(coin_num)
        queue_free()
    pass

func collect():
    is_collecting = true
    pass