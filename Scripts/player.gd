extends CharacterBody2D

@export var max_speed = 80
@export var acceleration = 500
@export var friction = 500

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_vector = input_vector.normalized()

	if input_vector:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_state.travel("Run")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()