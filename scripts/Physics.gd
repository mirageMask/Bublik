extends KinematicBody2D

const PX_HEIGHT:=12
const FPS = 60

onready var animPlayer := $AnimationPlayer

export var movement_speed:=30
export var jump_height_in_bodies:=3
export var jump_duration:=.3

var jump_max_height:float = PX_HEIGHT * jump_height_in_bodies / jump_duration

var gravity:Vector2 = Vector2(.0, jump_max_height / FPS / jump_duration)

var vect:=Vector2.ZERO

func _physics_process(delta):
	anim()
	physics()

#==========================
var x_vector_state :bool= 1
func physics():
	vect.x = 0
			
	if Input.is_action_pressed("jump") and is_on_floor():
		vect.y -= jump_max_height
	
	if Input.is_action_just_pressed("ui_right") : x_vector_state = 1
	if Input.is_action_just_pressed("ui_left")  : x_vector_state = 0

	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vect.x = movement_speed if x_vector_state else -movement_speed
	elif Input.is_action_pressed("ui_right") : vect.x = movement_speed
	elif Input.is_action_pressed("ui_left")  : vect.x =-movement_speed
		
	
	vect = move_and_slide(vect + gravity, Vector2.UP)
var a = 1
#==========================
func anim():

	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h = !x_vector_state
	elif Input.is_action_pressed("ui_right") : $AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left")  : $AnimatedSprite.flip_h = true

	if Input.is_action_pressed("jump"):
		animPlayer.play("jump" if vect.y<0 else "fall")
		return

	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		animPlayer.play("walk")
		return
	
	animPlayer.play("idle")