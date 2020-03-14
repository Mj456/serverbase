local spawnPos = vector3(1963.0, 3700.98, 32.31)

AddEventHandler('onClientGameTypeStart', function()
    exports.spawnmanager:setAutoSpawnCallback(function()
        exports.spawnmanager:spawnPlayer({
            x = spawnPos.x,
            y = spawnPos.y,
            z = spawnPos.z,
            model = 'a_m_m_indian_01'
        }, function()
             TriggerEvent('chat:addMessage', {
                args = { 'Welcome to the server' }
            })
        end)
    end)

    -- enable auto-spawn
    exports.spawnmanager:setAutoSpawn(true)

    -- and force respawn when the game type starts
    exports.spawnmanager:forceRespawn()
end)