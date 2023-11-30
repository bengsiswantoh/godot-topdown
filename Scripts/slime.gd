extends CharacterBody2D

func create_death_effect():
	var death_effect_scene = load("res://Scenes/Effects/death_effect.tscn")
	var death_effect = death_effect_scene.instantiate()
	
	death_effect.global_position = global_position
	
	var world = get_tree().current_scene
	
	world.add_child(death_effect)


func _on_hurt_box_area_entered(area):
	create_death_effect()
	queue_free()
