extends Node2D

var current_cards = []

var card_start_loc = Vector2(0, 800)

var card_space = Vector2(0, 1000)

var card_types = 4

@export var card_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_card()
	add_card()
	add_card()
	add_card()
	
func remove_card(index: int):
	current_cards[index].free()
	current_cards.remove_at(index)

func add_card():
	var card = card_scene.instantiate()
	card.set_card_type(randi() % card_types)
	add_child(card)
	current_cards.append(card)
	
func update_card_target_positions():
	for i in range(len(current_cards)):
		current_cards[i].on_set_current_target(self.position + card_start_loc + (i * card_space))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
