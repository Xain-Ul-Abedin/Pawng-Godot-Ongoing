extends Node2D

## Main game scene controller.
##
## Manages goal detection zones, game boundaries, and scene-level transitions.

@onready var ball: CharacterBody2D = $Ball

func _ready() -> void:
	var screen_size := get_viewport_rect().size
	
	# Dynamically position goals based on viewport dimensions
	$GoalTop.global_position.y = -20 
	$GoalBottom.global_position.y = screen_size.y + 20

## Triggered when ball enters the top goal (Bottom player scores).
func _on_goal_top_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		ball.reset_ball()

## Triggered when ball enters the bottom goal (Top player scores).
func _on_goal_bottom_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		ball.reset_ball()

## Returns user to the main menu scene.
func _on_home_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
