modifier_item_pull_staff_passive = class({})

--------------------------------------------------------------------------------

function modifier_item_pull_staff_passive:OnCreated( kv )
	self.bonus_agility = self:GetAbility():GetSpecialValueFor( "bonus_agility" )
	self.bonus_health_regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_passive:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_passive:GetModifierBonusStats_Agility( params )
	return self.bonus_agility
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_passive:GetModifierConstantHealthRegen( params )
	return self.bonus_health_regen
end

--------------------------------------------------------------------------------