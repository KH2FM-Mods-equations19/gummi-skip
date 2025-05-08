function _OnInit()
    kh2libstatus, kh2lib = pcall(require, "kh2lib")
    if not kh2libstatus then
        print("ERROR (Gummi Skip): KH2-Lua-Library mod is not installed")
        CanExecute = false
        return
    end

    Log("KH2 Gummi Skip 1.0.0")
    RequireKH2LibraryVersion(2)
    RequirePCGameVersion()

    CanExecute = kh2lib.CanExecute
    if not CanExecute then
        return
    end

    gummiSkip = kh2lib.GummiSkip
end

function _OnFrame()
    if not CanExecute then
        return
    end

    for i=0, 16 do
        if ReadByte(gummiSkip + (i * 4)) >= 2 then
            WriteByte(gummiSkip + (i * 4), 0)
        end
    end
    for i=353, 361 do
        if ReadByte(gummiSkip + i) == 1 then
            WriteByte(gummiSkip + i, 2)
        end
    end
end
