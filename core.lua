local function OnDoubleClick(self, button)
  	if IsInGroup() then
    	playerIsLeader = UnitIsGroupLeader("player")
    	if playerIsLeader == true then
    		LFGListSearchPanel_SignUp(self:GetParent():GetParent():GetParent())
    		LFGListApplicationDialog.SignUpButton:Click()
    	else
    	    print("You're not the party leader, You can only quick apply as the party leader.") 
    	end
    else
    LFGListSearchPanel_SignUp(self:GetParent():GetParent():GetParent())
    LFGListApplicationDialog.SignUpButton:Click()
    end
end

for _, button in pairs(LFGListFrame.SearchPanel.ScrollFrame.buttons) do
    button:SetScript("OnDoubleClick", OnDoubleClick)
end