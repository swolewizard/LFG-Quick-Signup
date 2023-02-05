-- Declare function to automatically apply to a group
local function SignUp(button)
	-- Click the "SignUp" Button on the LFG frame
	LFGListSearchPanel_SignUp(button:GetParent():GetParent():GetParent())
	-- Click the "SignUp" Button on the Role Select dialog
	LFGListApplicationDialog.SignUpButton:Click()
end

-- Declare DoubleClick event handler function
local function OnDoubleClick(button, buttonName)
	-- When the player is not in a group, or is the leader of the group
	if (buttonName == "LeftButton" and (IsInGroup() ~= true or UnitIsGroupLeader("player") == true)) then
		-- Run function to apply to the group
		SignUp(button)
	end
end

-- Create EventFrame
local EventFrame = CreateFrame("Frame", "EventFrame")
-- Add Event Handler for LFG Search Results Displayed
EventFrame:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
-- Set function for event
EventFrame:SetScript("OnEvent", function(self, event, ...)
	-- Only continue if event matches exactly
	if (event == "LFG_LIST_SEARCH_RESULTS_RECEIVED") then
		-- Get the LFGList "frames" ie list of groups
		local frames = LFGListFrame.SearchPanel.ScrollBox:GetView():GetFrames();
		-- Loop through all groups/listings
		for _, frame in ipairs(frames) do
			-- Ensure the frame actually has a double click hook
			if (frame.OnDoubleClick) then
				-- Set DoubleClick event handler
				frame:SetScript("OnDoubleClick", OnDoubleClick)
			end
		end
	end
end)
