extends RigidBody2D

enum State {
	UNAVAILABLE,
	AVAILABLE,
	CLAIMED
} 

var state = State.AVAILABLE

func _ready():
	set_state(state)

func set_state(new_state: int) -> void:
	state = new_state
	if state == State.UNAVAILABLE:
		$Sprite.texture = load("res://assets/Site_grey.png")
	if state == State.AVAILABLE:
		$Sprite.texture = load("res://assets/Site_orange.png")
	if state == State.CLAIMED:
		$Sprite.texture = load("res://assets/Site_purple.png")
