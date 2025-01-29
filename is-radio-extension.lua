--[[
  VLC extension for playing Icelandic radio channels streams.
  
  Add the `is-radio-extension.lua` file under the path corresponding with the operating system in use:

  - (Windows): %APPDATA%\vlc\lua\extensions\
  - (Linux): ~/.local/share/vlc/lua/extensions
  - (Mac): /Users/%your_name%/Library/Application Support/org.videolan.vlc/lua/extensions/

  Start up VLC and find the extension under 'View' -> 'Icelandic Radio'
--]]
 
stations = {
    { name = "Rúv - Rás 1", url = "https://ruv-radio-live.akamaized.net/streymi/ras1/ras1/ras1.m3u8" },
    { name = "Rúv - Rás 2", url = "https://ruv-radio-live.akamaized.net/streymi/ras2/ras2/ras2.m3u8" },
    { name = "Rúv - Rondo", url = "https://ruv-radio-live.akamaized.net/streymi/rondo/rondo/rondo.m3u8" },
    { name = "Bylgjan", url = "https://live.visir.is/hls-radio/bylgjan/chunklist_DVR.m3u8" },
    { name = "Bylgjan - Gull", url = "https://live.visir.is/hls-radio/gullbylgjan/chunklist_DVR.m3u8" },
    { name = "Bylgjan - Létt", url = "https://live.visir.is/hls-radio/lettbylgjan/chunklist_DVR.m3u8" },
    { name = "Bylgjan - Country", url = "https://live.visir.is/hls-radio/fmextra/chunklist_DVR.m3u8" },
    { name = "Bylgjan - Íslenskt", url = "https://live.visir.is/hls-radio/islenska/chunklist_DVR.m3u8" },
    { name = "Bylgjan - 80's", url = "https://live.visir.is/hls-radio/80s/chunklist_DVR.m3u8" },
    { name = "X977", url = "https://live.visir.is/hls-radio/x977/chunklist_DVR.m3u8" },
    { name = "FM 957", url = "https://live.visir.is/hls-radio/fm957/chunklist_DVR.m3u8" },
    { name = "Apparatið", url = "https://live.visir.is/hls-radio/apparatid/chunklist_DVR.m3u8" },
}
 
 
function descriptor()
    return { 
        title = "Icelandic Radio" ;
        version = "1.3" ;
        author = "Hrafn Thorvaldsson" ;
        capabilities = {} 
    }
end

function activate()
    dialog = vlc.dialog("Icelandic Radio")
    list = dialog:add_list()
    button_play = dialog:add_button("Play", click_play)

    for index, details in ipairs(stations) do
        list:add_value(details.name, index)
    end
    dialog:show()
end
 
function click_play()
    selection = list:get_selection()
    if (not selection) then return 1 end
    local sel = nil
    for index, selectedItem in pairs(selection) do
        sel = index
        break
    end
    details = stations[sel]

    vlc.playlist.clear()
    vlc.playlist.add({{path = details.url; title = details.name; name = details.name}})
    vlc.playlist.play()
end
 
function deactivate()
end
 
function close()
    vlc.deactivate()
end
