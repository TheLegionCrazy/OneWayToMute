local oneWayToMute = {}

oneWayToMute.config = "onewaytomute"
oneWayToMute.allChat = "all_chat"
oneWayToMute.enemiesChat = "enemies_chat"
oneWayToMute.whispersBC = "whispers"

oneWayToMute.optionEnable = Menu.AddOption({ "Utility", "OneWayToMute" }, "Enable", "Enabling script")
oneWayToMute.optionMuteAll = Menu.AddKeyOption({ "Utility", "OneWayToMute", }, "Toggle all chat key", Enum.ButtonCode.KEY_M)
oneWayToMute.optionMuteEnemies = Menu.AddKeyOption({ "Utility", "OneWayToMute", }, "Toggle chat from enemies key", Enum.ButtonCode.KEY_X)
oneWayToMute.optionMuteWhispers = Menu.AddKeyOption({ "Utility", "OneWayToMute", }, "Toggle whispers chat key", Enum.ButtonCode.KEY_Y)

oneWayToMute.all = 0
oneWayToMute.enemies = 0
oneWayToMute.whispers = 1

function oneWayToMute.OnUpdate()
    if not Menu.IsEnabled(oneWayToMute.optionEnable) then
        return
    end
	
	local toggle
	local command

    if Menu.IsKeyDownOnce(oneWayToMute.optionMuteAll) then
	    if (oneWayToMute.all == 0) then
		    oneWayToMute.all = 1
			toggle = "You've muted all chat"
		else 
            oneWayToMute.all = 0
			toggle = "You've unmuted all chat"
        end			
		
		command = "dota_chat_mute_everyone " .. oneWayToMute.all
        Config.WriteInt("onewaytomute", "all_chat", oneWayToMute.all)
    end
    if Menu.IsKeyDownOnce(oneWayToMute.optionMuteEnemies) then
	    if (oneWayToMute.enemies == 0) then
		    oneWayToMute.enemies = 1
			toggle = "You've muted chat from enemies"
		else 
            oneWayToMute.enemies = 0
			toggle = "You've unmuted chat from enemies"
        end		
		
		command = "dota_chat_mute_enemies " .. oneWayToMute.enemies
        Config.WriteInt(oneWayToMute.config, oneWayToMute.enemiesChat, oneWayToMute.enemies)  
    end
    if Menu.IsKeyDownOnce(oneWayToMute.optionMuteWhispers) then
	    if (oneWayToMute.whispers == 0) then
		    oneWayToMute.whispers = 1
			toggle = "You've enabled whispers"
		else 
            oneWayToMute.whispers = 0
			toggle = "You've disabled whispers"
        end			
		
		command = "dota_chat_broadcast_whispers " .. oneWayToMute.whispers
        Config.WriteInt(oneWayToMute.config, oneWayToMute.whispersBC, oneWayToMute.whispers)
    end	
	
	if (toggle ~= nil) then
	    Alerts.Add(toggle)
	end 
	if (command ~= nil) then
	    Engine.ExecuteCommand(command)
	end 
end

function oneWayToMute.OnScriptLoad()
    oneWayToMute.all = Config.ReadInt(oneWayToMute.config, oneWayToMute.allChat, 0)
	oneWayToMute.enemies = Config.ReadInt(oneWayToMute.config, oneWayToMute.enemiesChat, 0)  
	oneWayToMute.whispers = Config.ReadInt(oneWayToMute.config, oneWayToMute.whispersBC, 1)
end

return oneWayToMute