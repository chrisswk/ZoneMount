ZoneMount = {
  SLASH_COMMAND = "/zone_mount",
  CONTINENT_NAMES = {
    [-1] = "Cosmic",
    [0]  = "Azeroth",
    [1]  = "Kalimdor",
    [2]  = "Eastern KIngdoms",
    [3]  = "Outland",
    [4]  = "Northrend",
    [5]  = "The Maelstrom",
    [6]  = "Pandaria",
    [7]  = "Draenor"
  }
}

function ZoneMount.GetContinentName(continentId)
  return ZoneMount.CONTINENT_NAMES[continentId]
end

function ZoneMount.GetCurrentContinentName()
  return ZoneMount.GetContinentName(GetCurrentMapContinent())
end

function ZoneMount.InContinent(continentName)
  return ZoneMount.GetCurrentContinentName() == continentName
end

-- For some reason IsFlyableArea() returns +true+ in Draenor
function ZoneMount.IsReallyFlyableArea()
  return IsFlyableArea() and not ZoneMount.InContinent("Draenor")
end

function ZoneMount.GarrisonMount()
  return (GetSpellInfo("Garrison Ability"))
end

function ZoneMount.HasGarrisonMount()
  return ZoneMount.GarrisonMount() == "Telaari Talbuk" or
         ZoneMount.GarrisonMount() == "Frostwolf War Wolf"
end

function ZoneMount.DismountIfMounted()
  if IsMounted() then
    Dismount()
  end
end

function ZoneMount.GetZoneMount(flyingMount, groundMount)
  if ZoneMount.HasGarrisonMount() then
    return ZoneMount.GarrisonMount()
  elseif ZoneMount.IsReallyFlyableArea() then
    return flyingMount
  else
    return groundMount
  end
end

function ZoneMount.Mount(mountName)
  CastSpellByName(mountName)
end

function printUsage()
  print("|cFFFFFF00[Usage]|r")
  print(exampleSlashCommand("<flyingMount>", "<groundMount>"))
  print("|cFFFFFF00[Examples]|r")
  print(exampleSlashCommand("Dark Phoenix", "Raven Lord"))
  print(exampleSlashCommand("Albino Drake", "Black War Bear"))
end

function exampleSlashCommand(flyingMount, groundMount)
  return string.format("    %s \"%s\" \"%s\"", ZoneMount.SLASH_COMMAND, flyingMount, groundMount)
end

function printError(errorMsg)
  print("|cFFFF0000[ZoneMount Error]|r")
  print(errorMsg)
  print(string.format("Run '%s help' to see how to use ZoneMount.", ZoneMount.SLASH_COMMAND))
end

SLASH_ZONEMOUNT1 = ZoneMount.SLASH_COMMAND

SlashCmdList["ZONEMOUNT"] = function(args, editBox)
  local flyingMount, groundMount

  if args == "" or args == "help" or args == "usage" then
    printUsage()
    return
  end

  flyingMount, groundMount = args:match('"([^"]+)"%s+"([^"]+)"')

  if flyingMount and groundMount then
    ZoneMount.DismountIfMounted()
    ZoneMount.Mount(ZoneMount.GetZoneMount(flyingMount, groundMount))
  else
    printError("You must specify both a flying mount and ground mount.")
  end
end
