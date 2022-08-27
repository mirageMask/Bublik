extends KinematicBody2D

const PX_HEIGHT := 12.0

export var seconds_before_peak:=.3

# TODO:
export var seconds_after_peak:=.5

export var gravity := 128

export var jump_height_heads:=2

export var jump_max_height :float= 64.0*PX_HEIGHT*jump_height_heads

var jump_state :=.0
# warning-ignore:unused_argument
func _physics_process(delta):
	var step :float= jump_max_height * delta / seconds_before_peak
	anim_set_jump()
	var vect := Vector2(.0,step)
	# start pulling til the unpress or a peak
	if Input.is_action_pressed("jump"):
		if jump_state <= jump_max_height:
			anim_set_jump()
			vect.y=-step
			jump_state +=step
		elif is_on_floor():
			jump_state=.0
		else: anim_set_fall()
	elif is_on_floor():  anim_set_idle()
	# on_unpress of a button start pushing
	vect=move_and_slide(vect, Vector2.UP)





enum AnimList{
	idle,
	jump,
	fall
}

func anim_set_idle(): $AnimationTree.set("parameters/movement/current",AnimList.idle)
func anim_set_jump(): $AnimationTree.set("parameters/movement/current",AnimList.jump)
func anim_set_fall(): $AnimationTree.set("parameters/movement/current",AnimList.fall)












var Debug = DebugerCLS.new()

class DebugerCLS:
	var seconds:float
	var seconds_tmp:int
	func print_each_second(delta:float,text):
		seconds+=delta
		if int(seconds) > seconds_tmp:
			seconds_tmp=int(seconds)
			print(text)
