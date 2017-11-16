--- this version of the main.lua is the textured implementation
--- of the project
--- rename to 'main.lua' to use it

function love.load()
  debug = false
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  texWidth = 64
  texHeight = 64
  mapWidth = 24
  mapHeight = 24
  worldMap = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,7,7,7,7,7,7,7,7},
   {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,7},
   {4,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7},
   {4,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7},
   {4,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,7},
   {4,0,4,0,0,0,0,5,5,5,5,5,5,5,5,5,7,7,0,7,7,7,7,7},
   {4,0,5,0,0,0,0,5,0,5,0,5,0,5,0,5,7,0,0,0,7,7,7,1},
   {4,0,6,0,0,0,0,5,0,0,0,0,0,0,0,5,7,0,0,0,0,0,0,8},
   {4,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,1},
   {4,0,8,0,0,0,0,5,0,0,0,0,0,0,0,5,7,0,0,0,0,0,0,8},
   {4,0,0,0,0,0,0,5,0,0,0,0,0,0,0,5,7,0,0,0,7,7,7,1},
   {4,0,0,0,0,0,0,5,5,5,5,0,5,5,5,5,7,7,7,7,7,7,7,1},
   {6,6,6,6,6,6,6,6,6,6,6,0,6,6,6,6,6,6,6,6,6,6,6,6},
   {8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
   {6,6,6,6,6,6,0,6,6,6,6,0,6,6,6,6,6,6,6,6,6,6,6,6},
   {4,4,4,4,4,4,0,4,4,4,6,0,6,2,2,2,2,2,2,2,3,3,3,3},
   {4,0,0,0,0,0,0,0,0,4,6,0,6,2,0,0,0,0,0,2,0,0,0,2},
   {4,0,0,0,0,0,0,0,0,0,0,0,6,2,0,0,5,0,0,2,0,0,0,2},
   {4,0,0,0,0,0,0,0,0,4,6,0,6,2,0,0,0,0,0,2,2,0,2,2},
   {4,0,6,0,6,0,0,0,0,4,6,0,0,0,0,0,5,0,0,0,0,0,0,2},
   {4,0,0,5,0,0,0,0,0,4,6,0,6,2,0,0,0,0,0,2,2,0,2,2},
   {4,0,6,0,6,0,0,0,0,4,6,0,6,2,0,0,5,0,0,2,0,0,0,2},
   {4,0,0,0,0,0,0,0,0,4,6,0,6,2,0,0,0,0,0,2,0,0,0,2},
   {4,4,4,4,4,4,4,4,4,4,1,1,1,2,2,2,2,2,2,3,3,3,3,3}
  }

  -- X and Y start position
  posX = 22
  posY = 12
  -- intial direction vector
  dirX = -1
  dirY = 0
  -- the 2D ray caster version of camera plane
  planeX = 0
  planeY = 0.66

  buffer = {}
  texture = {}
  for x = 0, texWidth - 1 do
    texture[x] = {}
    for y = 0, texHeight - 1 do
      texture[x][y] = 0
    end
  end

  for x = 0, texWidth - 1 do
    for y = 0, texHeight - 1 do
      --local xorcolor = (x * 256 / texWidth) ^ (y * 256 / texHeight)
      local xorcolor = bit.bxor(x * 256 / texWidth, y * 256 / texHeight)
      -- xcolor = x * 256 / texWidth
      local ycolor = y * 256 / texHeight
      local xycolor = y * 128 / texHeight + x * 128 / texWidth
      local boolInt
      if ( x ~= y and x ~= texWidth - y) then boolInt = 1 else boolInt = 0 end
      texture[0][texWidth * y + x] = 65536 * 224 * boolInt -- flat red texture with black cross
      texture[1][texWidth * y + x] = xycolor + 256 * xycolor + 65536 * xycolor -- sloped greyscale
      texture[2][texWidth * y + x] = 256 * xycolor + 65536 * xycolor -- sloped yellow gradient
      texture[3][texWidth * y + x] = xorcolor + 256 * xorcolor + 65536 * xorcolor -- xor greyscale
      texture[4][texWidth * y + x] = 256 * xorcolor -- xor green
      boolInt = (x % 16 and y % 16)
      texture[5][texWidth * y + x] = 65536 * 192 * boolInt -- red brick
      texture[6][texWidth * y + x] = 65536 * ycolor -- red gradient
      texture[7][texWidth * y + x] = 128 + 256 * 128 + 65536 * 128 -- flat grey texture
    end
  end
  for x = 100, 200 do
    local thi = texture[5][x]
    local rgb = getRGB(thi)
    print(thi, rgb[1], rgb[2], rgb[3] )
end
  w = love.graphics.getWidth()
  h = love.graphics.getHeight()
  Stripes = {}

  left = false
  right = false
  forward = false
  back = false
end

function love.update(dt)
  for x = 0, w - 1 do
    -- calculate ray position and direction
    local cameraX = 2 * x / w - 1
    local rayPosX = posX
    local rayPosY = posY
    local rayDirX = dirX + planeX * cameraX
    local rayDirY = dirY + planeY * cameraX

    -- which box of the map we're in
    local mapX = math.floor(rayPosX)
    local mapY = math.floor(rayPosY)

    -- length of ray from current position to next x or y-side
    local sideDistX
    local sideDistY

    -- length of ray from one x or y-side to the next x or y-side
    local deltaDistX = math.sqrt(1 + (rayDirY ^ 2) / (rayDirX ^ 2))
    local deltaDistY = math.sqrt(1 + (rayDirX ^ 2) / (rayDirY ^ 2))
    local perpWallDist

    -- waht direction to step in x or y-direction (either +1 or -1)
    local stepX
    local stepY

    local hit = 0 -- was there a wall hit?
    local side -- was a NS or EW wall hit?

    -- calculate step and initial sideDist
    if rayDirX < 0 then
      stepX = -1
      sideDistX = (rayPosX - mapX) * deltaDistX
    else
      stepX = 1
      sideDistX = (mapX + 1.0 - rayPosX) * deltaDistX
    end

    if rayDirY < 0 then
      stepY = -1
      sideDistY = (rayPosY - mapY) * deltaDistY
    else
      stepY = 1
      sideDistY = (mapY + 1.0 - rayPosY) * deltaDistY
    end

    -- perform DDA
    while hit == 0 do
      -- jump to next map square, OR in x-direction , OR in y-direction
      if sideDistX < sideDistY then
        sideDistX = sideDistX + deltaDistX
        mapX = mapX + stepX
        side = 0
      else
        sideDistY = sideDistY + deltaDistY
        mapY = mapY + stepY
        side = 1
      end
      -- Check if ray hit the wall
      if worldMap[mapX][mapY] > 0 then hit = 1 end
    end

    -- calculate distance projected on camera direction (oblique distance will give fisheye effect!)
    if side == 0 then
      perpWallDist = (mapX - rayPosX + (1 - stepX) / 2) / rayDirX
    else
      perpWallDist = (mapY - rayPosY + (1 - stepY) / 2) / rayDirY
    end

    -- calculate height of the line to draw on screen
    local lineHeight = h / perpWallDist

    -- caluclate lowest and highest pixel to fill in current stripe
    local drawStart = -lineHeight / 2 + h / 2
    if drawStart < 0 then drawStart = 0 end
    local drawEnd = lineHeight  / 2 + h / 2
    if drawEnd >= h then drawEnd = h - 1 end

    -- texturing calculations
    local texNum = worldMap[mapX][mapY] - 1 -- subracted from it so that texture 0 can be used

    -- calculate value of wallX
    local wallX -- where exactly the wall was hit
    if side == 0  then
      wallX = rayPosX + perpWallDist * rayDirY
    else
      wallX = rayPosY + perpWallDist * rayDirX
    end
    wallX = wallX - math.floor(wallX)

    -- x coordinate on the texture
    local texX = math.floor wallX * texWidth
    if side == 0 and rayDirX > 0 then texX = texWidth - texX - 1 end
    if side == 1 and rayDirY < 0 then texX = texWidth - texX - 1 end

    for y = drawStart, drawEnd - 1 do
      local d = y * 256 - h * 128 + lineHeight * 128 -- 256 and 128 factors to avoid floats
      local texY = ((d * texHeight) / lineHeight) / 256
      local color = texture[texNum][texHeight * texY + texX]
      -- make color darker for  y-sides: R, G, and B byte each divided through two with a "shift" and an "and"
      -- if side == 1 then color = (color >> 1 ) & 835571 -- not sure how to do this in lua
      buffer[y][x] = color
    end



--[[]]
    -- chose wall color
    local color = {0, 0, 0}

    if worldMap[mapX][mapY] == 1 then
      color = {255, 0, 0}
    elseif worldMap[mapX][mapY] == 2 then
      color = {0, 255, 0}
    elseif worldMap[mapX][mapY] == 3 then
      color = {0, 0, 255}
    elseif worldMap[mapX][mapY] == 4 then
      color = {255, 255, 255}
    else
      color = {255, 255, 0}
    end
--[[]]

    -- give x and y  sides different brightness
    if side == 1 then for c = 1, #color do color[c] = color[c] / 2 end end

    -- draw the pixels of the stripe as vertical line
    -- format {r, g, b, x, start, x, end}
    table.insert(Stripes, {color[1], color[2], color[3], x, drawStart, x, drawEnd})
  end
  local moveSpeed = dt * 5.0
  local rotSpeed = dt * 3.0
  if forward then
    if worldMap[math.floor(posX + dirX * moveSpeed)][math.floor(posY)] == 0 then
      posX = posX + dirX * moveSpeed
    end
    if worldMap[math.floor(posX)][math.floor(posY + dirY * moveSpeed)] == 0 then
      posY = posY + dirY * moveSpeed
    end
  end
  if back then
    if worldMap[math.floor(posX - dirX * moveSpeed)][math.floor(posY)] == 0 then
      posX = posX - dirX * moveSpeed
    end
    if worldMap[math.floor(posX)][math.floor(posY - dirY * moveSpeed)] == 0 then
      posY = posY - dirY * moveSpeed
    end
  end
  if right then
    -- both camera direction and camera plane must be rotated
    local oldDirX = dirX
    dirX = dirX * math.cos(-rotSpeed) - dirY * math.sin(-rotSpeed)
    dirY = oldDirX * math.sin(-rotSpeed) + dirY * math.cos(-rotSpeed)
    local oldPlaneX = planeX
    planeX = planeX * math.cos(-rotSpeed) - planeY * math.sin(-rotSpeed)
    planeY = oldPlaneX * math.sin(-rotSpeed) + planeY * math.cos(-rotSpeed)
  end
  if left then
    -- both camera direction and camera plane must be rotated
    local oldDirX = dirX
    dirX = dirX * math.cos(rotSpeed) - dirY * math.sin(rotSpeed)
    dirY = oldDirX * math.sin(rotSpeed) + dirY * math.cos(rotSpeed)
    local oldPlaneX = planeX
    planeX = planeX * math.cos(rotSpeed) - planeY * math.sin(rotSpeed)
    planeY = oldPlaneX * math.sin(rotSpeed) + planeY * math.cos(rotSpeed)
  end

end

function love.draw()
  for i = #Stripes,1, -1 do
    love.graphics.setColor(Stripes[i][1], Stripes[i][2], Stripes[i][3])
    love.graphics.line(Stripes[i][4], Stripes[i][5], Stripes[i][6], Stripes[i][7])
    table.remove(Stripes, i)
  end
  --Stripes = {}
  debugDraw(debug)

end

function love.keypressed(key)
  if key == 'w' then forward = true end
  if key == 'a' then left = true end
  if key == 'd' then right = true end
  if key == 's' then back = true end

end

function love.keyreleased(key)
  if key == 'escape' then love.event.quit() end
  if key == 'p' then if debug then debug = false else debug = true end end

  if key == 'w' then forward = false end
  if key == 'a' then left = false end
  if key == 'd' then right = false end
  if key == 's' then back = false end
end

function debugDraw(debug)
  if debug then
    local text = {
      "FPS: " .. tostring(love.timer.getFPS()),
      "Stripes artifacts: " .. tostring(#Stripes)
    }
    local x = 10
    local y = 10
    local w = 250
    local h = 2 + #text * 16 + 2

    love.graphics.setColor(0, 0, 0, 128)
    love.graphics.rectangle('fill', x, y, w, h)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('line', x, y, w, h)
    for i = 1, #text do
      love.graphics.print(text[i], x + 2, y + 2 + (i - 1) * 16)
    end
  end
end

function getRGB(int24)
  local t = {}
  while int24 > 0 do
    rest = math.fmod(int24, 2)
    t[#t+1] = rest
    int24 = (int24 - rest) / 2
  end
  local str = {'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'}
  for i = #t, 1, -1 do str[i] = tostring(t[i]) end
  str = table.concat(str)

  return {
    bin2int(string.reverse(string.sub(str, 17, 24))),
    bin2int(string.reverse(string.sub(str, 9, 16))),
    bin2int(string.reverse(string.sub(str, 1, 8)))
  }
end

function bin2int(bin)
  bin = string.reverse(bin)
  local sum = 0

  for i = 1, string.len(bin) do
    num = string.sub(bin, i,i) == "1" and 1 or 0
    sum = sum + num * math.pow(2, i-1)
  end
  return sum
end
