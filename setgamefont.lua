getgenv().setgamefont = function(path)
    local font
    
    if typeof(path) == "EnumItem" and path.EnumType == Enum.Font then
        font = path
    elseif typeof(path) == "string" then
        local success, f = pcall(Font.new, path:match("^rbxassetid://") and path or getcustomasset(path))
        if success then font = f end
    elseif typeof(path) == "Font" then
        font = path
    end
    
    if not font then return end
    
    local function set(o)
        if not (o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox")) then return end
        pcall(function()
            if typeof(font) == "EnumItem" then
                o.Font = font
            else
                o.FontFace = font
            end
        end)
    end
    
    for _,v in game:GetDescendants() do set(v) end
    
    local cg = game:FindService("CoreGui")
    if cg then
        for _,v in cg:GetDescendants() do set(v) end
    end
    
    game.DescendantAdded:Connect(set)
    if cg then cg.DescendantAdded:Connect(set) end
end
