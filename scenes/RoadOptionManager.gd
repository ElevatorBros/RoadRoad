extends Node2D

var current_cards = []

var card_start_loc = Vector2(-750, 300)

var card_space = Vector2(500, 0)

var card_types = 5

@export var card_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	current_cards = []
	card_start_loc = Vector2(-460, -260)
	card_space = Vector2(300, 0)
	card_types = 5

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
	move_child(card, 1)
	current_cards.append(card)
	
func update_card_target_positions():
	for i in range(len(current_cards)):
		current_cards[i].find_child("Label").set_text(str(i + 1))
		current_cards[i].on_set_current_target(self.position + card_start_loc + (i * card_space))

func use_card(index: int) -> int:
	var type = get_type(index)
	#remove_card(index)
	#add_card()
	current_cards[index].free()
	current_cards.remove_at(index)
	var card = card_scene.instantiate()
	card.set_card_type(randi() % card_types)
	add_child(card)
	move_child(card, 1)
	#current_cards[index] = card
	current_cards.insert(index, card)
	update_card_target_positions()
	return type

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Car.spin_deck:
		remove_card(0)
		remove_card(0)
		remove_card(0)
		remove_card(0)
		add_card()
		add_card()
		add_card()
		add_card()
		update_card_target_positions()
		Car.spin_deck = false
