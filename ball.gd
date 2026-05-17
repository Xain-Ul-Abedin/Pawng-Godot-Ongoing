extends CharacterBody2D

# Added @export so you can change these right in the Inspector!
@export var base_speed: float = 250.0 
@export var speed_multiplier: float = 1.05 # 1.05 means +5% increase

var current_speed: float = 250.0
var normal_scale: Vector2

func _ready():
	normal_scale = scale
	reset_ball()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		# Use your custom multiplier from the Inspector!
		current_speed *= speed_multiplier 
		
		var bounce_dir = velocity.bounce(collision.get_normal()).normalized()
		velocity = bounce_dir * current_speed

func reset_ball():
	# 1. Stop the ball from moving completely
	velocity = Vector2.ZERO
	current_speed = base_speed
	
	# 2. Teleport to the center
	global_position = get_viewport_rect().size / 2
	
	# 3. Shrink the ball to be completely invisible
	scale = Vector2.ZERO
	
	# 4. Create the Tween for the smooth transition!
	var tween = create_tween()
	
	# Tell the tween to animate our "scale" back to "normal_scale" over 1.0 seconds
	tween.tween_property(self, "scale", normal_scale, 1.0)
	
	# 5. Tell the tween to call launch_ball() the exact moment the 1-second animation finishes
	tween.tween_callback(launch_ball)

func launch_ball():
	# Pick a random diagonal direction and apply the starting speed
	var random_x = [-1, 1].pick_random()
	var random_y = [-1, 1].pick_random()
	velocity = Vector2(random_x, random_y).normalized() * current_speed
