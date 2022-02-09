

local ConVar_Tbl = include("includes/convars.lua")
local Info_Tbl = include("includes/info.lua")

local tree = {}
local allInfo = {}

function OpenHEquipmentSettings()
    local main = vgui.Create( "DFrame" )
	main:SetSize(700, 700)
	main:DockPadding(20, 40, 20, 20)
	main:SetSizable(true)
	main:SetTitle( "Halo Equipment Settings" ) 
	main:SetVisible( true ) 
	main:SetDraggable( true ) 
	main:ShowCloseButton( true ) 
	main:MakePopup()
	main:Center()

	local resetAll = vgui.Create("DButton", main)
	resetAll:Dock(BOTTOM)
	resetAll:SetText("Reset ALL Settings")
	resetAll.DoClick = function()
		for tbl_name, tbl_convars in pairs(ConVar_Tbl) do
			for _, convar in pairs(tbl_convars) do
				LocalPlayer():ConCommand(convar["convar"].." "..convar["default"])
			end
		end
	end

	tree = vgui.Create("DTree", main)
	tree:Dock(LEFT)
	tree:SetSize(200, 0)
	local swNode = tree:AddNode("Halo")
	swNode:SetExpanded(true)

	local equipN = swNode:AddNode("Equipment")
	equipN:SetExpanded(true)

	local general = equipN:AddNode("General Settings")

    
	local sheet = nil
    if LocalPlayer():IsAdmin() then
        for tbl_name, tbl_convars in SortedPairs(ConVar_Tbl) do
            local node = equipN:AddNode(tbl_name)
            if (Info_Tbl[tbl_name]["icon"]!=nil) then node:SetIcon("entities/"..Info_Tbl[tbl_name]["icon"]) end
            node.DoClick = function()
                if !IsValid(sheet) then
                    sheet = vgui.Create("DPropertySheet", main)
                    sheet:Dock(FILL)
                    sheet.tabs = {}
                    sheet:SetFadeTime(0)
                end
                for k, v in pairs(sheet:GetItems()) do
                    print(v.Name)
                    if (v.Name == tbl_name) then
                        sheet:SetActiveTab(v.Tab)
                        return
                    end
                end
                local unitP = CreateEquipmentPanel(tbl_name, tbl_convars)
                local tab_Tbl = sheet:AddSheet(tbl_name, unitP)
                unitP:SetParent(sheet)
                sheet:SetActiveTab(tab_Tbl.Tab)
                tab_Tbl.Tab.DoRightClick = function(self)
                    if (#sheet:GetItems()<=1) then
                        sheet:Remove()
                    else
                        sheet:CloseTab(self, true)
                    end
                    
                end
                table.SortByMember(sheet:GetItems(), "Name")
            end
        end
	end
end

function CreateEquipmentPanel(tbl_name, tbl_convars, parent)
	local frame = vgui.Create("DPanel", parent)
	frame.Paint = nil

	local scroll = vgui.Create("DScrollPanel", frame)
	scroll:Dock(FILL)

	local button = vgui.Create("DButton", frame)
	button:Dock(BOTTOM)
	button:SetText("Reset Equipment Settings")
	button.DoClick = function()
		for _, convar in pairs(tbl_convars) do
			LocalPlayer():ConCommand(convar["convar"].." "..convar["default"])
		end
	end

	local form = vgui.Create("DForm", scroll)
	form:Dock(TOP)
	form:SetName(tbl_name)
	form:DoExpansion(true)
	form.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(0,0,100, 225))
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	if Info_Tbl[tbl_name]["entity"]!=nil then
		local model = vgui.Create("DModelPanel", form)
		model:SetSize(200, 200)
		model:SetModel(Info_Tbl[tbl_name]["entity"])
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

	for convarName, convar in pairs(tbl_convars) do
		local label = vgui.Create("DLabel", form)
		label:SetText(convarName)
		label:SetToolTip(convar["tooltip"])
		label:Dock(LEFT)

		local item = nil
		if (convar["panel"]["type"]=="DNumberWang") then
			item = vgui.Create("DNumberWang")
			item:SetMin(convar["panel"]["min"])
			item:SetMax(convar["panel"]["max"])
			item:Dock(TOP)
			item:SetToolTip(convar["tooltip"])
			item:SetValue(GetConVar(convar["convar"]):GetFloat())
			item:SetConVar(convar["convar"])
		elseif (convar["panel"]["type"]=="DNumberSlider") then
			item = vgui.Create("DNumSlider")
			item:SetMin(convar["panel"]["min"])
			item:SetMax(convar["panel"]["max"])
			item:SetDecimals(0)
			item:Dock(TOP)
			item:SetToolTip(convar["tooltip"])
			item:SetConVar(convar["convar"])
			item:SetValue(GetConVar(convar["convar"]):GetFloat())
		elseif (convar["panel"]["type"]=="DCheckbox") then
			item = vgui.Create("DCheckBox")
			item:SetValue(GetConVar(convar["convar"]):GetBool())
			item:Dock(LEFT)
			item:SetToolTip(convar["tooltip"])
			item:SetConVar(convar["convar"])
			item.DoClick = function()
				item:Toggle()
			end
		elseif (convar["panel"]["type"]=="DComboBox") then
			item = vgui.Create("DComboBox")
			item:SetValue(GetConVar(convar["convar"]):GetString())
			item:Dock(TOP)
			item:SetToolTip(convar["tooltip"])
			for k, v in pairs(convar["panel"]["options"]) do
				print(v)
				item:AddChoice(k, v)
			end
			item.OnSelect = function(index, value, data)
				LocalPlayer():ConCommand(convar["convar"].." "..data)
			end
		end
		form:AddItem(label, item)
	end

	return frame
end



function allInfo:AddConvars(table)

end


net.Receive("HaloEquipmentMsg", function()
    OpenHEquipmentSettings()
end)

return allInfo