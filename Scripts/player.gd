extends CharacterBody2D

@export var max_speed = 80
@export var acceleration = 500
@export var friction = 500

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var weapon = $Weapon


enum {
	MOVE,
	ATTACK
}

var state = MOVE

func _ready():
	animation_tree.active = true
	weapon.visible = false

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_vector = input_vector.normalized()

	if input_vector:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_tree.set("parameters/Attack/blend_position", input_vector)
		animation_state.travel("Run")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		state = ATTACK

func attack_state(delta):
	velocity = Vector2.ZERO
	animation_state.travel("Attack")

func attack_animation_finished():
	state = MOVE
