require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/findflower"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/faceentity"

local beecommon = require "brains/mutantbeecommon"

local MAX_CHASE_DIST = 25
local MAX_CHASE_TIME = 10

local RUN_AWAY_DIST = 3
local STOP_RUN_AWAY_DIST = 6

local MIN_FOLLOW_DIST = 2
local MAX_FOLLOW_DIST = 8
local TARGET_FOLLOW_DIST = 3

local function GetLeader(inst)
	return inst.components.follower and inst.components.follower.leader
end

local function GetFaceTargetFn(inst)
	return inst.components.follower and inst.components.follower.leader
end

local function KeepFaceTargetFn(inst, target)
	return inst.components.follower ~= nil and inst.components.follower.leader == target
end

local DefenderBeeBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

function DefenderBeeBrain:OnStart()
	local root =
		PriorityNode(
		{
			WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
			WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
			WhileNode( function() return self.inst.components.combat.target ~= nil end,
				"Attack",
				ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST)
			),
			Follow(self.inst, function() return GetLeader(self.inst) end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
			IfNode(function() return GetLeader(self.inst) ~= nil end, "HasLeader",
				FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn )),
			DoAction(self.inst, function() return beecommon.GoHomeAction(self.inst) end, "go home", true ),
			Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, beecommon.MAX_WANDER_DIST)
		}, 0.5)


	self.bt = BT(self.inst, root)
end

function DefenderBeeBrain:OnInitializationComplete()
	self.inst.components.knownlocations:RememberLocation("home", Point(self.inst.Transform:GetWorldPosition()))
end

return DefenderBeeBrain
