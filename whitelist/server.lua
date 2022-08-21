----------------------------------------
--- Discord Whitelist ---
----------------------------------------

--- Config ---
notWhitelisted = "Agent-S-Roleplay » Du bist nicht gewhitelisted. Bitte joine dafür auf unseren Discord Server » https://discord.gg/c4wve8WYGP" -- Message displayed when they are not whitelist with the role
noDiscord = "Agent-S-Roleplay » Bitte öffne Discord bevor Du dich verbindest." -- Message displayed when discord is not found

roles = { -- Role nickname(s) needed to pass the whitelist
    "Whitelist",
}


--- Code ---

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local src = source
    deferrals.defer()
    deferrals.update("Agent-S-Roleplay » Berechtigung werden geprüft")

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        for i = 1, #roles do
            if exports.permission:IsRolePresent(src, roles[i]) then
                deferrals.done()
            else
                deferrals.done(notWhitelisted)
            end
        end
    else
        deferrals.done(noDiscord)
    end
end)