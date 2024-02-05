extends CardState

func enter() -> void:
	
	state_name = "released"
	
	card_ui.color.color = Color.DARK_VIOLET
	card_ui.state.text = "RELEASED"

	print("play card for target(s) ", card_ui.targets)
