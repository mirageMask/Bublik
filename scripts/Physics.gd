extends KinematicBody2D

const PX_HEIGHT:=12
const FPS = 60
const min_lives:=0
const max_live:=99

onready var animPlayer := $AnimationPlayer

export var movement_speed:=30
export var jump_height_in_bodies:=3
export var jump_duration:=.3
export var lives:=3

var start_position:Vector2

var jump_max_height:float = PX_HEIGHT * jump_height_in_bodies / jump_duration

var gravity:Vector2 = Vector2(.0, jump_max_height / FPS / jump_duration)

var vect:=Vector2.ZERO


func _ready():
	set_physics_process(false)
	start_position = position
	Signals.connect("damaged",self,"_on_splike_hit")
	Signals.connect("game_started",self,'start_game')

func _physics_process(_delta):
	anim()
	physics()

#==========================
var x_vector_state :int= 1

func lives_report():
	Signals.emit_signal("lives_count", lives)

func physics():
	if Input.is_action_pressed("jump") and is_on_floor():
		vect.y -= jump_max_height
		
	if Input.is_action_just_pressed("ui_right") : x_vector_state = 1
	elif Input.is_action_just_pressed("ui_left")  : x_vector_state = -1
	var direction := int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))

	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vect.x = movement_speed * x_vector_state
	else: vect.x = movement_speed * direction
		
	
	vect = move_and_slide(vect + gravity, Vector2.UP)
#==========================
func anim():

	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h = x_vector_state==-1
	elif Input.is_action_pressed("ui_right") : $AnimatedSprite.flip_h = false
	else: $AnimatedSprite.flip_h = Input.is_action_pressed("ui_left")

	if Input.is_action_pressed("jump") or !is_on_floor():
		animPlayer.play("jump" if vect.y<0 else "fall")
		return

	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		animPlayer.play("walk")
		return
	
	animPlayer.play("idle")



func _on_splike_hit(body:Node):
	if body == self:
		set_physics_process(false)
		animPlayer.play("death")
		yield(get_tree().create_timer(animPlayer.get_animation("death").length), "timeout")
		if lives > 0:
			lives-=1
			lives_report()
			position = start_position
			set_physics_process(true)
		else: get_tree().reload_current_scene()



func start_game():
	set_physics_process(true)
	lives_report()
