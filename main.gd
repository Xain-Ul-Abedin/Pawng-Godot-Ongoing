extends Node2D

# This grabs a reference to your Ball node so we can talk to it
@onready var ball = $Ball

func _ready():
	# Get the exact size of the device screen
	var screen_size = get_viewport_rect().size
	
	# Snap the top goal slightly above the top edge
	$GoalTop.global_position.y = -20 
	
	# Snap the bottom goal slightly below the bottom edge
	$GoalBottom.global_position.y = screen_size.y + 20

func _on_goal_top_body_entered(body):
	# Check if the object that hit the goal is named "Ball"
	if body.name == "Ball":
		print("Bottom Player Scores!")
		ball.reset_ball()

func _on_goal_bottom_body_entered(body):
	if body.name == "Ball":
		print("Top Player Scores!")
		ball.reset_ball()


func _on_home_btn_pressed():
	# This destroys the current game and takes you back to the menu
	get_tree().change_scene_to_file("res://main_menu.tscn")
