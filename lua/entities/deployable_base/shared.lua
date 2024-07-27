ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.Category = "Halo Equipment"
ENT.Author = "Sgt Flexxx"
ENT.Contact = "https://steamcommunity.com/id/sgtflexxx/"
ENT.Purpose = "To debug the equipment system"
ENT.Instructions = ""
ENT.Spawnable = true
ENT.PrintName = "Deployable Base"
ENT.AutomaticFrameAdvance = true

if (CLIENT) then
    function ENT:Draw()
        self:DrawModel()
    end
end