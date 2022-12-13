-----------------
--[[ Imports ]]--
-----------------

local imports = {
    getElementsByType = getElementsByType,
    addEventHandler = addEventHandler,
    getPlayerSerial = getPlayerSerial,
    dbExec = dbExec,
    assetify = assetify
}


----------------
--[[ Module ]]--
----------------

local moduleInfo = {
    moduleName = "serial",
    tableName = "dbify_serials",
    keyName = "serial",
    keyType = "string"
}
dbify.createModule(moduleInfo)

imports.assetify.scheduler.execOnModuleLoad(function()
    imports.dbExec(dbify.mysql.connection.instance, "CREATE TABLE IF NOT EXISTS `??` (`??` VARCHAR(100) PRIMARY KEY)", dbify.module[(moduleInfo.moduleName)].connection.table, dbify.module[(moduleInfo.moduleName)].connection.key)
    if not dbify.settings.syncNativeSerials then return false end
    local playerList = imports.getElementsByType("player")
    for i = 1, #playerList, 1 do
        local playerSerial = imports.getPlayerSerial(playerList[i])
        dbify.module[(moduleInfo.moduleName)].create(playerSerial)
    end
    imports.addEventHandler("onPlayerJoin", root, function()
        dbify.module[(moduleInfo.moduleName)].create(imports.getPlayerSerial(source))
    end)
end)