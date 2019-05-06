extends MeshInstance

export var LIGHTEN = 0.5

onready var anim = get_child(0)
onready var player = get_parent().get_parent()

func _ready():
	var i = 0
	while i<mesh.get_surface_count():
		var material = mesh.surface_get_material(i)
		if !material:
			i+=1
			continue
		material.albedo_color.r += LIGHTEN
		material.albedo_color.g += LIGHTEN
		material.albedo_color.b += LIGHTEN
		i+=1

	anim.play("idle")
	pass

var needs_jump = true

func _process(delta):
	if player.is_grounded:
		var vel = player.linear_velocity
		vel.y = 0
		if vel.length_squared() > 0.1:
			anim.play("walk")
		else:
			anim.play("idle")
		needs_jump = true
	else:
		if needs_jump:
			anim.play("jump")
			needs_jump = false
	
	pass