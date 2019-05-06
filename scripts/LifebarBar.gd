extends Sprite

export var HEALTH_SPEED = 0.5

func _ready():
    region_enabled = true
    region_rect.size = texture.get_size()
    pass

func _process(delta):
    var dest_progress = globals.player.health/globals.player.MAX_HEALTH
    var src_progress = region_rect.size.x / texture.get_size().x
    var progress = src_progress + (dest_progress-src_progress) * HEALTH_SPEED

    region_rect.size.x = texture.get_size().x*progress

    pass