-- Declare function to automatically apply to a group
local function SignUp(button)
	-- If an application is already open, do not continue
	if (button.isApplication) then return end
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

local function AddDoubleClickHook(frame)
	frame:SetScript("OnDoubleClick", OnDoubleClick)
end

local function LogError(msg)
	error("Failed to set double click script")
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
			-- Set DoubleClick event handler but log any errors
			xpcall(AddDoubleClickHook, LogError, frame)
		end
	end
end)
