extends CharacterBody2D

const GRAVITY = 1000

enum State { idle, run }

var current_state

func _ready():
	current_state = State.idle

func _physics_process(delta):
	player_falling(delta)
	move_and_slide()
	player_idle(delta)
	player_run(delta)
	#$AnimatedSprite2D.play(State[current_state])
	print(State)
	

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
		velocity.x = direction * 300
		current_state = State.run
	else:
		velocity.x = 0
