extends MeshInstance

export var HEAL_AMOUNT = 1.0

func on_collect():
    globals.player.health = min(globals.player.health+HEAL_AMOUNT,globals.player.MAX_HEALTH)
    pass