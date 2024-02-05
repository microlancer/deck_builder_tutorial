extends CardState

func enter() -> void:
	
	state_name = "released"
	
	
	print("play card for target(s) ", card_ui.targets)
	
	card_ui.play()
	
