Board = {}

local function GetIndexXY(x, y)
  return tostring(x) .. '-' .. tostring(y)
end

local function Setup()
  for y = 1, 3 do
    for x = 1, 3 do
      local index = GetIndexXY(x,y)
      Board[index] = ' '
    end
  end

  NTurns = 0
end

local function PrintBoard()
  for y = 1, 3 do
    for x = 1, 3 do
      local index = GetIndexXY(x,y)
      io.write(Board[index] .. ' ')
    end
    io.write('\n')
  end
end

local function CheckWin()
  -- row check
  for y = 1, 3 do
    local r1, r2, r3 = Board[GetIndexXY(1,y)], Board[GetIndexXY(2,y)], Board[GetIndexXY(3,y)]
    if r1 ~= ' ' and (r1 == r2) and (r1 == r3) then
      return r1
    end
  end

  -- column check
  for x = 1, 3 do
    local c1, c2, c3 = Board[GetIndexXY(x,1)], Board[GetIndexXY(x,2)], Board[GetIndexXY(x,3)]
    if c1 ~= ' ' and (c1 == c2) and (c1 == c3) then
      return c1;
    end
  end

  -- cross check
  local lc1, lc2, lc3 = Board[GetIndexXY(1, 1)], Board[GetIndexXY(2,2)], Board[GetIndexXY(3,3)]
  if lc1 ~= ' ' and (lc1 == lc2) and (lc1 == lc3) then
    return lc1
  end

  local rc1, rc2, rc3 = Board[GetIndexXY(3, 1)], Board[GetIndexXY(2,2)], Board[GetIndexXY(1,3)]
  if rc1 ~= ' ' and (rc1 == rc2) and (rc1 == rc3) then
    return rc1
  end

  if NTurns == 9 then
    return "d"
  end

  return false
end

local function main()
  io.write("Tic-Tac-Toe!\nElements are accessed in x-y order (i.e \"x plays: 2-3\")\n")
  Setup()

  local turnX = true
  local GetTurn = function() if turnX then return 'x' else return 'o' end end
  local win;
  while true do
    win = CheckWin()
    if win then
      break
    end

    io.write(GetTurn() .. " plays: ")
    local move = io.read()

    if Board[move] == ' ' then
      if turnX then
        Board[move] = 'x'
      else
        Board[move] = 'o'
      end

      NTurns = NTurns + 1
      PrintBoard()
      turnX = not turnX
    else
      io.write("Block inaccessible; try again\n")
    end
  end

  if win == "d" then
    io.write("Draw\n")
  else
    io.write(win .. " won!\n")
  end
end

main()
