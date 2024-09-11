extends Node2D


@onready var brickObject = preload("res://scenes/brick.tscn")



var columns = 34
var rows = 7
var margin = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setupLevel()
	
	

func setupLevel():
	
	rows = 2 + GameManager.level
	
	if rows > 9:
		rows =9
	
	var colors = getColors()
	colors.shuffle()
	
	for r in rows:
		for c in columns:
			var randomNumber = randi_range(0,2)
			if randomNumber > 0:
			
				var newBrick = brickObject.instantiate()
				add_child(newBrick)
				newBrick.position = Vector2(margin + (34 * c), margin + (34 * r))

				var sprite = newBrick.get_node('Sprite2D')
				if r <= 9:
					sprite.modulate = colors[0]
				if r < 6:
					sprite.modulate = colors[1]
				if r < 3:
					sprite.modulate = colors[2]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func getColors():
	var colors = [
		Color(0, 1, 1, 1),
		Color(0.54, 0.17, 0.89, 1),
		Color(0.68, 1, 0.18, 1),
		Color(0, 1, 1, 1)
		]
	return colors
