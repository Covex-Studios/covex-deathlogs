local wasDead = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)
        local ped = PlayerPedId()
        if IsEntityDead(ped) and not wasDead then
            wasDead = true

            local coords = GetEntityCoords(ped)
            local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local street = GetStreetNameFromHashKey(streetHash)

            local killer = GetPedSourceOfDeath(ped)
            local killerServerId = nil
            if killer ~= ped and killer ~= 0 and IsPedAPlayer(killer) then
                killerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(killer))
            end

            local data = {
                victim = GetPlayerServerId(PlayerId()),
                killer = killerServerId,
                street = street,
                coords = { x = coords.x, y = coords.y, z = coords.z }
            }

            TriggerServerEvent("deathlog:playerDied", data)
        elseif not IsEntityDead(PlayerPedId()) then
            wasDead = false
        end
    end
end)