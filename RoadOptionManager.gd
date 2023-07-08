extends Node2D

var current_cards = []

var card_start_loc = Vector2(-1400, 700)

var card_space = Vector2(1000, 0)

var card_types = 5

@export var card_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_card()
	add_card()
	add_card()
	add_card()
	update_card_target_positions()
	
func get_type(index: int) -> int:
	return current_cards[index].current_type
	
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

func use_card(index: int) -> int:
	var type = get_type(index)
	remove_card(index)
	add_card()
	update_card_target_positions()
	
	return type

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
