extends Sprite

const FPS = 60

enum {
	IDLE
	JUMP
	FALL
	WALK
}

func anim(idx:int, arr):
	if frame + 1 in arr:
		frame += 1 + vframes * idx
	else :frame = 0


func anim_idle():anim(IDLE, [0, 1, 2, 3])
func anim_jump():anim(JUMP, [0])
func anim_fall():anim(FALL, [0])
func anim_walk():anim(WALK, range(6))


var frame_idx:int = 0
func timing(seconds:float, function:String):
	if frame_idx < FPS * seconds:
		frame_idx += 1
	else:
		frame_idx = 0
		call(function)




	# if is_on_floor(s):
	# 	# anim_idle(delta)
	# 	pass
