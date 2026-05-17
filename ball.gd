extends CharacterBody2D

## Core ball logic for Pawng.
##
## Manages physics-based movement, speed scaling, and reset animations.

@export_group("Physics Properties")
## Initial velocity magnitude at start/reset.
@export var base_speed: float = 250.0 
## Percentage increase in speed per collision (1.05 = 5%).
@export var speed_multiplier: float = 1.05 

var current_speed: float = 250.0
var normal_scale: Vector2

func _ready() -> void:
	normal_scale = scale
	reset_ball()

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	
	if collision:
		current_speed *= speed_multiplier 
		var bounce_dir := velocity.bounce(collision.get_normal()).normalized()
		velocity = bounce_dir * current_speed

## Resets ball position and state, executing a scale-in animation.
func reset_ball() -> void:
	velocity = Vector2.ZERO
	current_speed = base_speed
	global_position = get_viewport_rect().size / 2
	scale = Vector2.ZERO
	
	var tween := create_tween()
	tween.tween_property(self, "scale", normal_scale, 1.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_callback(launch_ball)

## Initiates ball movement in a random diagonal direction.
func launch_ball() -> void:
	var random_x := [-1, 1].pick_random()
	var random_y := [-1, 1].pick_random()
	velocity = Vector2(random_x, random_y).normalized() * current_speed
