class_name Hand
extends HBoxContainer

var cards_played_this_turn := 0

func _ready() -> void:
	Events.card_played.connect(_on_card_played)
	
	for child in get_children():
		var card_ui := child as CardUI
		card_ui.parent = self
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
		
func _on_card_played(_card: Card) -> void:
	cards_played_this_turn += 1
	
func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.reparent(self)
	var new_index := clampi(child.original_index - cards_played_this_turn, 0, get_child_count())
	# use call_deferred on built-in move_child() to make sure this happens at the end of the frame
	move_child.call_deferred(child, new_index)
	
