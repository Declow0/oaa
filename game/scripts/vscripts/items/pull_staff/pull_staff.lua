item_pull_staff = class({})
LinkLuaModifier( "modifier_item_pull_staff_passive", "items/pull_staff/modifier_item_pull_staff_passive.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_pull_staff_pull", "items/pull_staff/modifier_item_pull_staff_pull.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function item_pull_staff:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	local pull_duration = self:GetSpecialValueFor( "pull_duration" )

	EmitSoundOn( "DOTA_Item.ForceStaff.Activate", hTarget )

	hTarget:AddNewModifier( self:GetCaster(), self, "modifier_item_pull_staff_pull", nil )
end

--------------------------------------------------------------------------------

function item_pull_staff:GetIntrinsicModifierName()
	return "modifier_item_pull_staff_passive"
end