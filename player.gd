extends CharacterBody2D

@export var is_top_player: bool = false
# Two new toggles for our AI!
@export var is_ai: bool = false
@export var ai_speed: float = 350.0 

var screen_size: Vector2
var ball: Node2D

func _ready():
	screen_size = get_viewport_rect().size
	
	if is_ai:
		ball = get_parent().get_node_or_null("Ball")
		
	# -- NEW: Snap to the true top and bottom of the screen --
	if is_top_player:
		# 100 pixels down from the very top
		global_position.y = 100 
	else:
		# 100 pixels up from the very bottom
		global_position.y = screen_size.y - 100

func _physics_process(delta):
	# If this paw is an AI, and it successfully found the ball...
	if is_ai and ball:
		var target_x = ball.global_position.x
		
		# move_toward smoothly moves current position to target position by a set step size
		var new_x = move_toward(global_position.x, target_x, ai_speed * delta)
		
		# Keep the AI clamped safely on screen using your 25 pixel padding
		global_position.x = clamp(new_x, 25, screen_size.x - 25)

func _input(event):
	# If this paw is controlled by AI, ignore human touch inputs entirely!
	if is_ai:
		return
		
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var touch_y = event.position.y
		var is_touch_top_half = touch_y < (screen_size.y / 2)
		
		if (is_top_player and is_touch_top_half) or (not is_top_player and not is_touch_top_half):
			var safe_x = clamp(event.position.x, 25, screen_size.x - 25)
			global_position.x = safe_x
