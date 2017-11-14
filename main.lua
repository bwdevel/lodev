function love.load()
  debug = false

end

function love.update(dt)

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
