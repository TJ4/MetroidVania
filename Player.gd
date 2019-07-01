extends KinematicBody2D

var velocity = Vector2();

const WALK_SPEED = 60;
const GRAVITY = 10;
const JUMP_POWER = -200;
const FLOOR = Vector2(0, -1);

var on_ground = false
var jump_count = 0;
var max_jump_count = 2;

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = WALK_SPEED;
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED;
	else:
		velocity.x = 0;
		
	if Input.is_action_just_pressed("ui_up"):
		if on_ground:
			velocity.y += JUMP_POWER;
			on_ground = false;
			jump_count += 1;
		elif !on_ground and jump_count < max_jump_count:
			velocity.y = JUMP_POWER;
			jump_count += 1;
	
	velocity.y += GRAVITY;
	
	if is_on_floor():
		on_ground = true;
		jump_count = 0;
	else:
		on_ground = false;
		
	velocity = move_and_slide(velocity, FLOOR);