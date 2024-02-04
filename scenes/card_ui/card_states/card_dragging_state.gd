extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05
var minimum_drag_time_elapsed := false

func enter() -> void:
	
	state_name = "dragging"
	
	# This will let us break out of the Hand control box and allow the card to be dragged around
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
		
	card_ui.color.color = Color.NAVY_BLUE
	card_ui.state.text = "DRAGGING"
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func() : minimum_drag_time_elapsed = true)
	
func on_input(event: InputEvent) -> void:
	
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
		return
	
	var played
	
	if (cancel or confirm):			
		played = false	
		if not card_ui.targets.is_empty():
			played = true
	
	if (cancel) or (confirm and not played):
		get_viewport().set_input_as_handled() 
		transition_requested.emit(self, CardState.State.BASE)		
	elif minimum_drag_time_elapsed and (confirm and played):
		get_viewport().set_input_as_handled() 
		# This function will stop the event from propagating to other cards with event handlers.
		transition_requested.emit(self, CardState.State.RELEASED)
