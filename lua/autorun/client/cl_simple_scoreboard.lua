SIMPLE_SCOREBOARD = {
    Title = "SIMPLE SCOREBOARD",
    Ranks = {
        ["user"] = "User",
        ["admin"] = "Admin",
        ["superadmin"] = "Super Admin",
        ["founder"] = "Founder",
        ["owner"] = "Ownmer",
        ["vip"] = "VIP",
    },
    Theme = {
        frame = Color(0,0,0,200),
        panel = Color(0,0,0,200),
        theme = Color(219,219,219),
        gradient = Material("scoreboard/grad.png"),
        enable_gradient = true,
    },
    Padding = {
        x = ScrW() * .005,
        y = ScrH() * .01
    },
    SubTitle = {
        {title = "Players: ", getText = function() return player.GetCount() end},
        {title = "Total Money: ", getText = function() return DarkRP.formatMoney(SIMPLE_SCOREBOARD.GetTotalMoney()) end},
        {title = "", getText = function() return "BY DANFMN" end},
        {title = "Up Time: ", getText = function() return string.FormattedTime(CurTime(), "%02i:%02i" ) end},
    },
    PlayerInformation = {
        {title = "Rank: ", getText = function(ply) local rank = ply:GetUserGroup() rank = SIMPLE_SCOREBOARD.Ranks[rank] or rank return rank end},
        {title = "Job: ", getText = function(ply) return team.GetName(ply:Team()) end},
        {title = "Kills: ", getText = function(ply) return ply:Frags() end},
        {title = "Deaths: ", getText = function(ply) return ply:Deaths() end},
        {title = "Money: ", getText = function(ply) return DarkRP.formatMoney(ply:getDarkRPVar("money")) end},
        {title = "Ping: ", getText = function(ply) return ply:Ping() end},
    },
}

local fontSizes = {
    18,
    24,
    36,
}

for i = 1, #fontSizes do
    local size = fontSizes[i]
    surface.CreateFont( "Simple_Scoreboard_" .. size, {
        font = "Roboto",
        extended = false,
        size = size,
        weight = 500,
    } )
    
end

function SIMPLE_SCOREBOARD.Open()

    local scrw, scrh = ScrW(), ScrH()
    if IsValid(SIMPLE_SCOREBOARD.Menu) then 
        SIMPLE_SCOREBOARD.Menu:Remove()
    end
    SIMPLE_SCOREBOARD.Menu = vgui.Create("ScoreboardFrame")
    SIMPLE_SCOREBOARD.Menu:SetSize(scrw * .45, scrh * .8)
    SIMPLE_SCOREBOARD.Menu:Center()
    SIMPLE_SCOREBOARD.Menu:MakePopup()
    SIMPLE_SCOREBOARD.Menu:Show()
end



function SIMPLE_SCOREBOARD.Hide()
    if not IsValid(SIMPLE_SCOREBOARD.Menu) then return end
    SIMPLE_SCOREBOARD.Menu:Hide()
end

local totalMoney = 0
local lastCall = CurTime() - 5
function SIMPLE_SCOREBOARD.GetTotalMoney()
    if lastCall + 5 < CurTime() then
        for k,v in pairs(player.GetAll()) do
            totalMoney = totalMoney + v:getDarkRPVar("money")
        end
        lastCall = CurTime()
    end
    return totalMoney
end
--SCOREBOARD.BlurMenu( me, 16, 16, 255 )


hook.Add("ScoreboardShow", "SimpleScoreboard_Open", function()
    SIMPLE_SCOREBOARD.Open()
    return true
end)

hook.Add("ScoreboardHide", "SimpleScoreboard_Close", function()
    SIMPLE_SCOREBOARD.Hide()
    return true
end)