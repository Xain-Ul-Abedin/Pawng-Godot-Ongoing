extends CharacterBody2D

## Controller for both human players and AI agents.
##
## Handles input mapping for top/bottom halves of the screen or automated tracking.

@export_group("Configuration")
## Defines if the player is at the top or bottom of the screen.
@export var is_top_player: bool = false
## Toggles AI control for this instance.
@export var is_ai: bool = false
## Lateral speed of the AI tracker.
@export var ai_speed: float = 350.0 

var screen_size: Vector2
var ball: CharacterBody2D

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
	if is_ai:
		ball = get_parent().get_node_or_null("Ball") as CharacterBody2D
		
	if is_top_player:
		global_position.y = 100 
	else:
		global_position.y = screen_size.y - 100

func _physics_process(delta: float) -> void:
	if is_ai and ball:
		var target_x := ball.global_position.x
		var new_x := move_toward(global_position.x, target_x, ai_speed * delta)
		global_position.x = clamp(new_x, 25, screen_size.x - 25)

func _input(event: InputEvent) -> void:
	if is_ai:
		return
		
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var touch_y := event.position.y
		var is_touch_top_half := touch_y < (screen_size.y / 2)
		
		if (is_top_player and is_touch_top_half) or (not is_top_player and not is_touch_top_half):
			var safe_x := clamp(event.position.x, 25, screen_size.x - 25)
			global_position.x = safe_x
