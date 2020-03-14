local blips = {
  -- unique locations

-- Sandy Shores Blips --

  {title="Store", color=2, id=52, scale=1.0, x = 1963.63, y = 3743.17, z = 32.34},

  {title="Store", color=2, id=52, scale=1.0, x = 544.36, y = 2672.17, z = 42.16},
  
  {title="Robbery", color=59, id=110, scale=0.5, x = 1960.77, y = 3748.9, z = 32.34},

  {title="Yellow Jack", color=46, id=93, scale=0.945, x = 1994.53, y = 3049.57, z = 46.25},

  {title="Robbery", color=59, id=110, scale=0.5, x = 1999.74, y = 3048.98, z = 47.77},

  {title="Police Department", color=74, id=60, scale=1.01, x = 1853.16, y = 3687.39, z = 34.27},
  
  {title="Amunation", color=75, id=313, scale=1.0, x = 1693.63, y = 3758.8, z = 39.18},
  
  {title="Ace Liquor", color=46, id=51, scale=0.75, x = 1394.83, y = 3604.93, z = 34.98},

  {title="Airfield", color=83, id=251, scale=1.0, x = 1740.26, y = 3268.11, z = 41.22},

  {title="Prison", color=63, id=188, scale=1.0, x = 1845.89,  y = 2585.59,  z = 45.67},

  {title="Los Santos Customs", color=46, id=72, scale=0.70, x = 1177.02, y = 2640.78, z = 37.75},

  {title="Pharmacy", color=77, id=51, scale=0.80, x = 591.04, y = 2744.77, z = 42.04},

  {title="Recycling Center", color=69, id=365, scale=1.5, x = 2300.4, y = 3120.7, z =47.4},  

  {title="Robbery", color=59, id=110, scale=0.5, x = 1177.17, y = 2711.8, z = 37.17},

  {title="Robbery", color=59, id=110, scale=0.5, x = 546.66, y = 2663.59, z = 42.16},

-- Grape Seed --

  {title="Los Santos Customs", color=46, id=72, scale=0.75, x = 2498.11, y = 4081.28, z = 38.28},

  {title="Store", color=2, id=52, scale=0.75, x = 1703.25, y = 4925.27, z = 42.06},
  
  {title="Airfield", color=83, id=251, scale=1.0, x = 2129.05, y = 4803.64, z = 41.02},


-- Paleto bay --

  {title="Store", color=2, id=52, scale=0.75, x = 1731.89, y = 6413.7, z = 35.04},

  {title="Police Department", color=74, id=60, scale=1.01, x = -445.71, y = 6013.67, z = 31.72},

  {title="Los Santos Customs", color=46, id=72, scale=0.95, x = 109.91, y = 6626.99, z = 31.79},

  {title="Amunation", color=75, id=313, scale=0.78, x = -328.67, y = 6077.67, z = 32.45},

  {title="Medical Center", color=25, id=61, scale=0.75, x = -244.69, y = 6326.11, z = 32.43},

  {title="Robbery", color=59, id=110, scale=0.5, x = -103.91, y = 6477.57, z = 30.66, z = 42.16},


  -- City

  
  {title="Police Department", color=74, id=60, scale=1.0, x = 446.19, y = -984.9, z = 30.69},
  

  {title="Robbery", color=59, id=110, scale=0.5, x = 1707.52, y = 4920.09, z = 41.08},
  
  {title="Robbery", color=59, id=110, scale=0.5, x = 1734.48, y = 6420.27, z = 34.06},
  
  {title="Robbery", color=59, id=110, scale=0.5, x = -709.75, y = -904.07, z = 18.25},
  
  {title="Robbery", color=59, id=110, scale=0.5, x = -1220.8, y = -915.92, z = 10.55},
  
  {title="Robbery", color=59, id=110, scale=0.5, x = -43.29, y = -1748.33, z = 28.44},

  {title="Robbery", color=59, id=110, scale=0.5, x = 146.88, y = -1044.67, z = 28.50},

  {title="Medical Center", color=25, id=61, scale=1.0, x=292.53, y=-588.48, z=43.17},

  {title="Amunation", color=75, id=313, scale=1.0, x = 16.32, y = -1117.18, z = 29.79},

  {title="Car Dealership", color=69, id=225, scale=1.0, x=-44.13, y=-1090.55, z=26.46},


}
      
Citizen.CreateThread(function()

  for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, info.scale)
    SetBlipColour(info.blip, info.color)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end

end)