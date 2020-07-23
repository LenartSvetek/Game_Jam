extends KinematicBody2D

export (int) var speed = 500

var direction = Vector2(0,0)
var gravity = Vector2();
var jump = false
var dod=true
var pressed = false

func animation():
	if direction.x == 0:
		$CollisionShape2D/AnimatedSprite.play("stoji")
	if Input.is_action_pressed('right'):
		$CollisionShape2D/AnimatedSprite.flip_h=false
		$CollisionShape2D/AnimatedSprite.play("hod")
	if Input.is_action_pressed('left'):
		$CollisionShape2D/AnimatedSprite.flip_h=true
		$CollisionShape2D/AnimatedSprite.play("hod")

func _physics_process(delta):
	# Get player input
	direction.x = 0
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if direction.y != 0:
		if direction.y > 0:
			direction.y -= 0.5
			if direction.y < 0:
				direction.y = 0
		elif direction.y < 0:
			direction.y += 0.5
			if direction.y > 0:
				direction.y = 0
	if !move_and_collide(Vector2(0,0)):
		print(direction.x, " ", direction.y)
	else:
		direction.y = -Input.get_action_strength("up")
		if direction.y != 0.0:
			jump = true
	if jump == true:
		direction.y *= 5
		jump = false
		
	direction.x *= 1
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	
	# Apply movement
	gravity.y = speed * 0.9 * delta
	var movement = speed * direction * delta
	animation()
	move_and_collide(movement)
	move_and_collide(gravity)
