extends CharacterBody2D

const GRAVITY = 1000
const SPEED = 300

enum State { idle, run }

var current_state

func _ready():
	current_state = State.idle

func _physics_process(delta):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	move_and_slide()
	player_animations()
	

func player_falling(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
func player_idle(delta):
	if is_on_floor():
		current_state = State.idle
		
func player_run(delta):
	# Returns either 1 or -1 so we can determine the direction
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = direction * SPEED
		current_state = State.run
		# Ternary for determining if sprite needs to be flipped
		$AnimatedSprite2D.flip_h = false if direction > 0 else true
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
func player_animations():
	$AnimatedSprite2D.play(State.keys()[current_state])
