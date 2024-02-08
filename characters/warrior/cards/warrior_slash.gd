extends Card

@export var optional_sound: AudioStream

func apply_effects(targets: Array[Node]):
	print("My awesome card has been played!")
	print("Targets: %s" % targets)
	
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 4
	damage_effect.sound = self.sound
	damage_effect.execute(targets)

