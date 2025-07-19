local webhook = "https://discord.com/api/webhooks/1395751167090491403/SgVLrSsQ3GHQju02Qc5BYre4sgrnSNv7H5KklblxLQq-9FKhPYBwHd6b8m5BAqqg1X0H"
function sendDeathEmbed(data)
    local color, title, description, fields

    if data.victim == data.killer or not data.killer then
        title = "Covex Studios Death Logs"
        color = 16763904
        description = string.format("`%s` player has died (suicide or NPC).", data.victimName)
        fields = {
            { name = "Victim", value = "`" .. data.victimName .. "`", inline = true },
            { name = "Street", value = data.street or "`Unknown`", inline = true },
            { name = "Death Coordinates", value = string.format('`vector3(%.2f, %.2f, %.2f)`', data.coords.x, data.coords.y, data.coords.z), inline = true },
            { name = "Victim's Discord", value = data.victimDiscord or "`Not Linked`", inline = false }
        }
    else
        title = "Covex Studios Death Logs"
        color = 16711680 -- red
        description = string.format("`%s` was killed by `%s`.", data.victimName, data.killerName)
        fields = {
            { name = "Victim", value = "`" .. data.victimName .. "`", inline = true },
            { name = "Killer", value = "`" .. data.killerName .. "`", inline = true },
            { name = "Killer's Discord", value = data.killerDiscord or "`Not Linked`", inline = false },
            { name = "Street", value = data.street or "`Unknown`", inline = true },
            { name = "Death Coordinates", value = string.format('`vector3(%.2f, %.2f, %.2f)`', data.coords.x, data.coords.y, data.coords.z), inline = true },
            { name = "Victim's Discord", value = data.victimDiscord or "`Not Linked`", inline = false }
        }
    end

    local embed = {{
        ["title"] = title,
        ["color"] = color,
        ["description"] = description,
        ["thumbnail"] = { ["url"] = "https://i.ibb.co/ksB7GBHq/covex-background.png" },
        ["fields"] = fields,
        ["footer"] = { ["text"] = "Player Death Log • " .. os.date("%d/%m/%Y %I:%M %p") },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}

    PerformHttpRequest(webhook, function(err, text, headers)
        print("[DeathLog DEBUG] Discord webhook response code:", err)
    end, "POST", json.encode({ username = "Covex Studios | Server Logs", embeds = embed }), { ["Content-Type"] = "application/json" })
end

function getDiscordMention(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in ipairs(identifiers) do
        if string.sub(v, 1, 8) == "discord:" then
            return '<@' .. string.sub(v, 9) .. '>'
        end
    end
    return "`Not Linked`"
end

RegisterNetEvent("deathlog:playerDied")
AddEventHandler("deathlog:playerDied", function(data)
    local victimName = GetPlayerName(data.victim) or "Unknown"
    local killerName, killerDiscord
    if data.killer and data.killer ~= data.victim then
        killerName = GetPlayerName(data.killer) or "Unknown"
        killerDiscord = getDiscordMention(data.killer)
    end
    local victimDiscord = getDiscordMention(data.victim)

    sendDeathEmbed({
        victimName = victimName,
        killerName = killerName,
        killerDiscord = killerDiscord,
        street = data.street or "`Unknown`",
        coords = data.coords or { x = 0, y = 0, z = 0 },
        victimDiscord = victimDiscord,
        victim = data.victim,
        killer = data.killer
    })
end)
