extends CharacterBody2D

var start_position
var end_position

func _ready():
	start_position = position
	end_position = start_position + Vector2(0, 3 * 16)

func _physics_process(delta):
	var move_direction = end_position - start_position
	velocity = move_direction.normalized()
	move_and_slide()
