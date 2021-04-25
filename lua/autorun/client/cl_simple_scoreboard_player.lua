local PANEL = {}

function PANEL:Init()

end

function PANEL:SetPlayer(ply)
    local xPad, yPad = SIMPLE_SCOREBOARD.Padding.x, SIMPLE_SCOREBOARD.Padding.y
    self.ply = ply
	self.avatar = self:Add( "AvatarImage")
	self.avatar:Dock(LEFT)
	self.avatar:SetPlayer( ply, 64 )
    self.avatar:DockMargin(xPad, yPad, xPad, yPad)
    self.avatar.OnSizeChanged = function(me,w,h)
        me:SetWide(me:GetTall())
    end
    self.contentPanel = self:Add("DPanel")
    self.contentPanel:Dock(FILL)
    self.contentPanel:DockMargin(xPad, yPad, xPad, yPad)
    self.contentPanel.Paint = function(me,w,h)
        local xPad, yPad = SIMPLE_SCOREBOARD.Padding.x, SIMPLE_SCOREBOARD.Padding.y
        draw.SimpleText(self.ply:Name(), "Simple_Scoreboard_18", 0, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        local xPos = 0
        surface.SetFont("Simple_Scoreboard_18")
        for i = 1, #SIMPLE_SCOREBOARD.PlayerInformation do
            local infoData = SIMPLE_SCOREBOARD.PlayerInformation[i]
            local text = infoData.title .. " " .. infoData.getText(self.ply)
            local textW = surface.GetTextSize(text)
            draw.SimpleText(text, "Simple_Scoreboard_18", xPos, h, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            xPos = xPos + textW + xPad
        end
    end
end 

function PANEL:OnSizeChanged(w,h)

end

function PANEL:Paint(w,h)
    local theme = SIMPLE_SCOREBOARD.Theme
    surface.SetDrawColor(theme.panel)
    surface.DrawRect(0,0,w,h)
    surface.SetDrawColor(color_white)
    surface.DrawRect(0, h - 2, w, 2)
    if self.ply and IsValid(self.ply) then 
        surface.SetDrawColor(team.GetColor(self.ply:Team()))
        if theme.enable_gradient then 
            surface.SetMaterial(theme.gradient)
            surface.DrawTexturedRect(0,0,w,h)
        else
            surface.SetAlphaMultiplier(.2)
            surface.SetDrawColor(team.GetColor(self.ply:Team()))
            surface.DrawRect(0,0,w,h)
            surface.SetAlphaMultiplier(1)
        end

    end
end 


vgui.Register("ScoreboardPlayer", PANEL, "DPanel")