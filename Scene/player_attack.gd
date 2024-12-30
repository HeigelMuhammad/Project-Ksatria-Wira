extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var attacking = false

func _process(delta):
	if Input.is_action_just_pressed("serang"):
		attack()

func attack():
	attacking = true
	animation.play("attacking")



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func update_animation():
	if !attacking:
		if velocity.x != 0:
			animation.play("run")
		else :
			animation.play("idle")
		
		if velocity.y < 0:
			animation.play("jump")
		if velocity.y > 0:
			animation.play("jump")