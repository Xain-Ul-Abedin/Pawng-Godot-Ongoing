extends Control

func _on_single_player_btn_pressed():
	# Loads your 1-Player arena!
	get_tree().change_scene_to_file("res://single_player.tscn")

func _on_two_player_btn_2_pressed():
	# Loads your 2-Player arena!
	get_tree().change_scene_to_file("res://two_player.tscn")

func _on_quit_pressed():
	# Closes the game application
	get_tree().quit()
