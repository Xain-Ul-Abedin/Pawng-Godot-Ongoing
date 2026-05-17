extends Control

## Navigation controller for the entry-point scene.

## Transitions to the single-player arena.
func _on_single_player_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://single_player.tscn")

## Transitions to the local two-player arena.
func _on_two_player_btn_2_pressed() -> void:
	get_tree().change_scene_to_file("res://two_player.tscn")

## Terminates the application.
func _on_quit_pressed() -> void:
	get_tree().quit()
