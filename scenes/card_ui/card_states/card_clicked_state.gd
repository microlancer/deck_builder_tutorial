extends CardState

func enter() -> void:
	state_name = "clicked"
	# when i clicked the card, it will do this immediately:
	card_ui.drop_point_detector.monitoring = true
	
# This has nothing to do with click inputs. Only, "mouse motion" inputs.
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_viewport().set_input_as_handled() 
		transition_requested.emit(self, CardState.State.DRAGGING)
