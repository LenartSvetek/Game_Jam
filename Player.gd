extends "res://character.gd"

# Jumping
var can_jump = false
var jump_time = 0
const TOP_JUMP_TIME = 0.1 # in seconds

# Start
func _ready():
	# Set player properties
	acceleration = 1000
	top_move_speed = 400
	top_jump_speed = 500

func animation():
	if directional_force.x == 0:
		$CollisionShape2D/AnimatedSprite.play("stoji")
	if Input.is_action_pressed('right'):
		$CollisionShape2D/AnimatedSprite.flip_h=false
		$CollisionShape2D/AnimatedSprite.play("hod")
	if Input.is_action_pressed('left'):
		$CollisionShape2D/AnimatedSprite.flip_h=true
		$CollisionShape2D/AnimatedSprite.play("hod")

# Apply force
func apply_force(state):
	
	# Move Left
	if(Input.is_action_pressed("left")):
		if can_jump:
			directional_force += DIRECTION.LEFT
		else:
			directional_force += DIRECTION.LEFT/2
	
	# Move Right
	if(Input.is_action_pressed("right")):
		if can_jump:
			directional_force += DIRECTION.RIGHT
		else:
			directional_force += DIRECTION.RIGHT/2
	
	# Jump
	if(Input.is_action_pressed("up") && can_jump):
		directional_force += DIRECTION.UP
		jump_time += state.get_step()
		can_jump = false
		
	if get_colliding_bodies().size() != 0:
		var list = get_colliding_bodies()
		print(list.size())
		for i in range(0, list.size()):
			var groups = list[i].get_groups()
			if groups.has("solid"):
				can_jump = true
			elif groups.has("special"):
				print("hi")
	animation()
