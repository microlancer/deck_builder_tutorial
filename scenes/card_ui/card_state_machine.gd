class_name CardStateMachine
extends Node

@export var initial_state: CardState

var current_state: CardState
var states := {}

func init(card: CardUI) -> void:
	
	# This will grab CardBaseState, CardClickedState, etc. and fill our `states` var.
	# This will also set the local _on_transition_requested to be called on the signal
	# This will also initialize the CardUI value so it's available on every child	
	for child in get_children():
		if child is CardState:
			# Create all the states, and index them by the ENUM.
			states[child.state] = child
			
			# Have the child (base, clicked, dragged, released) state be connected
			# to (use) the _on_transition_requested function defined in this class itself.
			# When transition_requested is emitted, then call this function.
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card

	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)
		
func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)
		
func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()
		
func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()
		
func _on_transition_requested(from: CardState, to: CardState.State) -> void:
	if from != current_state:
		return
		
	var new_state: CardState = states[to] # Grab the child state by the ENUM
	if not new_state:
		return
		
	if current_state: # if something is wrong
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
