extends KinematicBody2D

const PX_HEIGHT:=12
const FPS = 60

onready var sprite := $Sprite


export var movement_speed:=20
export var jump_height_in_bodies:=2
export var jump_duration:=.5

var jump_max_height:float = PX_HEIGHT * jump_height_in_bodies / jump_duration

var gravity:Vector2 = Vector2(.0, jump_max_height / FPS / jump_duration)

var vect:=Vector2.ZERO

func _physics_process(delta):
		
	vect.x = 0 ;
	if Input.is_action_just_pressed("jump"):
		vect.y -= jump_max_height
		sprite.timing(.2, "anim_idle")
	if Input.is_action_pressed("ui_left"):
		vect.x =- movement_speed
		sprite.timing(.2, "anim_idle")
	if Input.is_action_pressed("ui_right"):
		vect.x =+ movement_speed

	vect = move_and_slide(vect + gravity, Vector2.UP)
