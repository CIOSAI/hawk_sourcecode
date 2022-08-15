extends Node2D

enum FACING {RIGHT = 1, LEFT = -1}

onready var tw = $"Tween"
onready var thigh = $"Model/ModelTransform/AnchorBody/Body/AnchorThigh"
onready var leg = $"Model/ModelTransform/AnchorBody/Body/AnchorThigh/Thigh/AnchorLeg"
onready var foot = $"Model/ModelTransform/AnchorBody/Body/AnchorThigh/Thigh/AnchorLeg/Leg/AnchorFoot"
onready var earL = $"Model/ModelTransform/AnchorBody/Body/AnchorHead/Head/AnchorEarL"
onready var earR = $"Model/ModelTransform/AnchorBody/Body/AnchorHead/Head/AnchorEarR"

export var hind_limb_hop_dur:float
export var hind_limb_contract_dur:float
export var hind_limb_extend = {
	thigh = 0.0,
	leg = 0.0,
	foot = 0.0
}

var hind_limb_contract = {
	thigh = 0.0,
	leg = 0.0,
	foot = 0.0
}

var t:float = 0
var hind_limb_extend_value:float = 0
var facing:int = FACING.RIGHT

func _ready():
	hind_limb_contract.thigh = thigh.rotation
	hind_limb_contract.leg = leg.rotation
	hind_limb_contract.foot = foot.rotation

func set_facing(n:int):
	facing = n

func leg_extend(x:float):
	thigh.rotation = lerp(
		hind_limb_contract.thigh, 
		hind_limb_contract.thigh+hind_limb_extend.thigh, x)
	leg.rotation = lerp(
		hind_limb_contract.leg, 
		hind_limb_contract.leg+hind_limb_extend.leg, x)
	foot.rotation = lerp(
		hind_limb_contract.foot, 
		hind_limb_contract.foot+hind_limb_extend.foot, x)

func hop():
	tw.interpolate_property(
		self, "hind_limb_extend_value",
		0, 1,
		hind_limb_hop_dur, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tw.interpolate_property(
		self, "hind_limb_extend_value",
		1, 0,
		hind_limb_contract_dur, Tween.TRANS_CIRC, Tween.EASE_OUT,
		hind_limb_hop_dur)
	tw.start()

func _process(delta):
	scale.x = facing
	
	leg_extend(hind_limb_extend_value)
	
	t += delta
	t -= floor(t)
