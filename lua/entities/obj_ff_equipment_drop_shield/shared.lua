ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Category = "Halo Equipment"
ENT.Author = "Sgt Flexxx"
ENT.Contact = "https://steamcommunity.com/id/sgtflexxx/"
ENT.Purpose = "To give the user Drop Shield."
ENT.Instructions = "Press the activate key activate Drop Shield."
ENT.Spawnable = true
ENT.PrintName = "Drop Shield Equipment"
ENT.ConVarName = "drop_shield"

ENT.oldConvar = ENT.UseConvars
function ENT:UseConvars()
    self.oldConvar(self)
end