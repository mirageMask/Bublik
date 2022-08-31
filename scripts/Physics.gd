extends KinematicBody2D

const PX_HEIGHT:=12
const FPS = 60

onready var animPlayer := $AnimationPlayer
onready var animSprite := $AnimatedSprite

export var movement_speed:=30
export var jump_height_in_bodies:=3
export var jump_duration:=.3

var jump_max_height:float = PX_HEIGHT * jump_height_in_bodies / jump_duration

var gravity:Vector2 = Vector2(.0, jump_max_height / FPS / jump_duration)

var vect:=Vector2.ZERO

func _physics_process(delta):
	vect.x = 0

	if is_on_floor() and vect.x == 0:
		animPlayer.play("idle")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vect.y -= jump_max_height
		animPlayer.play("jump")
	if Input.is_action_pressed("ui_left"):
		vect.x =- movement_speed
		animSprite.flip_h = true
		animPlayer.play("walk")

	if Input.is_action_pressed("ui_right"):
		vect.x =+ movement_speed
		animSprite.flip_h = false
		animPlayer.play("walk")

	

		
	vect = move_and_slide(vect + gravity, Vector2.UP)
