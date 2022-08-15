extends Node2D

const tile_size:float = 64.0*32.0

export var ground:PackedScene
export var amount:int

var tiles = []
var tile_pos = []

func _ready():
	for i in amount:
		var g = ground.instance()
		
		var index:int = -i/2 if i%2==0 else ceil(i/2.0)
		g.position.x = float(index)*tile_size
		tile_pos.append(index)
		
		add_child(g)
		tiles.append(g)

func tile_ground(x:float):
	var cent:int = int(round(x/tile_size))
	var require_tile = []
	for i in amount:
		require_tile.append(
			cent + int( -i/2 if i%2==0 else ceil(i/2.0) )
		)
	
	for t in tiles.size():
		if require_tile.has(tile_pos[t]):
			require_tile.erase(tile_pos[t])
	
	for t in tiles.size():
		if abs(tiles[t].position.x-x)+tile_size/2 > tile_size*7:
			if !require_tile.empty():
				tile_pos[t] = require_tile.pop_front()
				tiles[t].position.x = tile_pos[t]*tile_size
