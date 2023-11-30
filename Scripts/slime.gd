extends CharacterBody2D

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var death_effect_scene = load("res://Scenes/Effects/death_effect.tscn")
		var death_effect = death_effect_scene.instantiate()
		
		death_effect.global_position = global_position
		
		var world = get_tree().current_scene
		
		world.add_child(death_effect)
		
		queue_free()
