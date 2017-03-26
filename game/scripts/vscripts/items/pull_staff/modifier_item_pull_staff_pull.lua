modifier_item_pull_staff_pull = class({})

--------------------------------------------------------------------------------

function modifier_item_pull_staff_pull:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_pull:GetOverrideAnimation( params )
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_pull:GetEffectName()
	return "particles/items_fx/force_staff.vpcf"
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_pull:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_pull:IsDebuff()
	if self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
		return true
	end

	return false
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_pull:OnCreated( kv )
	self.target = self:GetParent()

	self.pull_length = self:GetAbility():GetSpecialValueFor( "pull_length" )
	self.pull_speed = self:GetAbility():GetSpecialValueFor( "pull_speed" )
	self.tree_radius = self:GetAbility():GetSpecialValueFor( "tree_radius" )

	self.remaining_length = self.pull_length
	
	self.tick_rate = 0.03

	if IsServer() then
		self.pull_direction = self.target:GetForwardVector():Normalized()

		self:OnIntervalThink()
		self:StartIntervalThink( self.tick_rate )
	end
end

--------------------------------------------------------------------------------

function modifier_item_pull_staff_pull:OnRefresh( kv )
	self.remaining_length = self.pull_length
end


--------------------------------------------------------------------------------

function modifier_item_pull_staff_pull:OnIntervalThink( kv )
	if IsServer() then
		GridNav:DestroyTreesAroundPoint( self.target:GetOrigin(), self.tree_radius, true )
		local fLengthPerTick = self.pull_speed * self.tick_rate

		if self.remaining_length > 0 then
			local vCoord = self.target:GetAbsOrigin() - self.pull_direction * fLengthPerTick
			self.target:SetAbsOrigin( GetGroundPosition( vCoord, self.target) )

			self.remaining_length = self.remaining_length - fLengthPerTick
		else
			FindClearSpaceForUnit(self.target, self.target:GetAbsOrigin(), true)
			self:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
