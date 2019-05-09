extends Spatial

onready var mesh = get_child(0) 

func on_collect():
    var weapon = globals.player.get_node("Camera/WeaponContainer/Weapon")
    weapon.mesh = mesh.mesh
    weapon.scale = mesh.scale
    weapon.rotation = mesh.rotation
    weapon.translation = mesh.translation
    weapon.init_weapon_mesh()
    pass