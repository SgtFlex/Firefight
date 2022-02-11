local ConVar_Tbl = include("includes/convars.lua")
local Info_Tbl = include("includes/info.lua")

local allInfo = {}
function CreateSettingsMenu()
	local main = vgui.Create( "DFrame" )
	main:SetSize(700, 700)
	main:DockPadding(20, 40, 20, 20)
	main:SetSizable(true)
	main:SetTitle( "Flex's Settings Panel" ) 
	main:SetVisible( true ) 
	main:SetDraggable( true ) 
	main:ShowCloseButton( true ) 
	main:MakePopup()
	main:Center()

	local tree = vgui.Create("DTree", main)
	tree:Dock(LEFT)
	tree:SetSize(200, 0)



	function tree:CreateNode(nodeName, nodeInfo)
		local node = self:AddNode(nodeName)
		node.CreateNode = self.CreateNode

		function node:CreateNodeSheet(nodeName, nodeInfo)
			print(self.Name)
			local frame = vgui.Create("DPanel", main)
			frame.Paint = nil
		
			local scroll = vgui.Create("DScrollPanel", frame)
			scroll:Dock(FILL)
		
			local form = vgui.Create("DForm", scroll)
			form:Dock(TOP)
			form:SetName(nodeName)
			form:DoExpansion(true)
			form.Paint = function(self, w, h)
				draw.RoundedBox(6, 0, 0, w, h, Color(0,0,100, 225))
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawOutlinedRect(0, 0, w, h, 1)
			end
		
			if (nodeInfo["model"]!=nil) then
				local model = vgui.Create("DModelPanel", form)
				model:SetSize(200, 200)
				model:SetModel(nodeInfo["model"])
				local z = select(2, model.Entity:GetRenderBounds()).z
				model:SetCamPos(Vector(model.Entity:GetModelRadius()*2,0,z))
				model:SetLookAt(Vector(0,0,z/2))
				model:SetAnimated(true)
				model.PaintOver = function(self, w, h)
					surface.SetDrawColor(255, 255, 255, 255)
					surface.DrawOutlinedRect(0, 0, w, h)
				end
				form:AddItem(model)
			end
			PrintTable(nodeInfo)
			for controlName, controlInfo in SortedPairs(nodeInfo["controls"]) do
				local label = vgui.Create("DLabel", form)
				label:SetText(controlName)
				label:SetTooltip(controlInfo["desc"])
				label:Dock(LEFT)
		
				local item = nil
				if (controlInfo["panel"]["type"]=="DNumberSlider") then
					item = vgui.Create("DNumSlider")
					item:SetMin(controlInfo["panel"]["min"])
					item:SetMax(controlInfo["panel"]["max"])
					item:SetDecimals(0)
					item:Dock(TOP)
					item:SetTooltip(controlInfo["desc"])
					item:SetConVar(controlInfo["convar"])
					item:SetValue(GetConVar(controlInfo["convar"]):GetFloat())
				elseif (controlInfo["panel"]["type"]=="DCheckbox") then
					item = vgui.Create("DCheckBox")
					item:SetValue(GetConVar(controlInfo["convar"]):GetBool())
					item:Dock(LEFT)
					item:SetTooltip(controlInfo["desc"])
					item:SetConVar(controlInfo["convar"])
					item.DoClick = function()
						item:Toggle()
					end
				elseif (controlInfo["panel"]["type"]=="DComboBox") then
					item = vgui.Create("DComboBox")
					item:SetValue(GetConVar(controlInfo["convar"]):GetString())
					item:Dock(TOP)
					item:SetTooltip(controlInfo["desc"])
					for k, v in pairs(controlInfo["panel"]["options"]) do
						item:AddChoice(k, v)
					end
					item.OnSelect = function(index, value, data)
						LocalPlayer():ConCommand(controlInfo["convar"].." "..data)
					end
				else --Create a DNumberWang by default
					item = vgui.Create("DNumberWang")
					item:SetMin(controlInfo["panel"]["min"])
					item:SetMax(controlInfo["panel"]["max"])
					item:Dock(TOP)
					item:SetTooltip(controlInfo["desc"])
					item:SetValue(GetConVar(controlInfo["convar"]):GetFloat())
					item:SetConVar(controlInfo["convar"])
				end
				form:AddItem(label, item)
			end
		
			-- local button = vgui.Create("DButton", frame)
			-- button:Dock(BOTTOM)
			-- button:SetText("Reset Equipment Settings")
			-- button.DoClick = function()
			-- 	for _, convar in pairs(tbl_controls) do
			-- 		LocalPlayer():ConCommand(controlInfo["convar"].." "..controlInfo["default"])
			-- 	end
			-- end
		
			return frame
		end



		if (nodeInfo["icon"]!=nil) then node:SetIcon(nodeInfo["icon"]) end
		node.DoClick = function()
			if (nodeInfo["controls"]!=nil) then
				if !IsValid(sheet) then
					sheet = vgui.Create("DPropertySheet", main)
					sheet:Dock(FILL)
					sheet.tabs = {}
					sheet:SetFadeTime(0)
				end
				for k, v in pairs(sheet:GetItems()) do
					if (v.Name == nodeName) then
						sheet:SetActiveTab(v.Tab)
						return
					end
				end
				local unitP = self:CreateNodeSheet(nodeName, nodeInfo)
				local tab_Tbl = sheet:AddSheet(nodeName, unitP)
				unitP:SetParent(sheet)
				sheet:SetActiveTab(tab_Tbl.Tab)
				tab_Tbl.Tab.DoRightClick = function(self)
					if (#sheet:GetItems()<=1) then
						sheet:Remove()
					else
						sheet:CloseTab(self, true)
					end                    
				end
			end
		end
		if (nodeInfo["subtree"]!=nil) then
			for nodeName, nodeInfo in SortedPairs(nodeInfo["subtree"]) do
				node:CreateNode(nodeName, nodeInfo) --Get the subtree of this node and run this again
			end
		end

		return node
	end
    



	local sheet = nil
	for nodeName, nodeInfo in SortedPairs(ConVar_Tbl) do
		tree:CreateNode(nodeName, nodeInfo)
	end

	-- local resetAll = vgui.Create("DButton", main)
	-- resetAll:Dock(BOTTOM)
	-- resetAll:SetText("Reset ALL Settings")
	-- resetAll.DoClick = function()
	-- 	for tbl_name, tbl_controls in pairs(allInfo) do
	-- 		for _, convar in pairs(tbl_controls) do
	-- 			LocalPlayer():ConCommand(convar["convar"].." "..convar["default"])
	-- 		end
	-- 	end
	-- end
end





function allInfo:AddControls(tbl)
	table.insert(allInfo, tbl)
end



net.Receive("SettingsPanel", function()
    CreateSettingsMenu()
end)

return allInfo