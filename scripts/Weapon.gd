extends MeshInstance

export var LIGHTEN = 0.5

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
	pass