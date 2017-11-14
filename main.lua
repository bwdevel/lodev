function love.load()
  debug = false
  mapWidth = 24
  mapHeight = 24
  worldMap = {
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
    {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,3,0,0,0,3,0,0,0,1},
    {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,4,0,0,0,0,5,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,4,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
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

  w = 512 - 1
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
    local prepWallDist

    -- waht direction to step in x or y-direction (either +1 or -1)
    local stepX
    local stepY

    local hit = 0 -- was there a wall hit?
    local side -- was a NS or EW wall hit?

    --- continue from here...
  end

end

function love.draw()
  debugDraw(debug)

end

function love.keypressed(key)

end

function love.keyreleased(key)
  if key == 'escape' then love.event.quit() end
  if key == 'p' then if debug then debug = false else debug = true end end
end

function debugDraw(debug)
  if debug then
    local text = {
      "FPS: " .. tostring(love.timer.getFPS())
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
