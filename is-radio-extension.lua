--[[
  VLC extension for playing Icelandic radio channels streams.
  
  Add the `is-radio-extension.lua` file under the path corresponding with the operating system in use:

  - (Windows): %APPDATA%\vlc\lua\extensions\
  - (Linux): ~/.local/share/vlc/lua/extensions
  - (Mac): /Users/%your_name%/Library/Application Support/org.videolan.vlc/lua/extensions/

  Start up VLC and find the extension under 'View' -> 'Icelandic Radio'
--]]
 
stations = {
	{ name = "RUV 426x240", url = "http://ruvruv-live.hls.adaptive.level3.net/ruv/ruv/index/stream1.m3u8" },
	{ name = "RUV 640x360", url = "http://ruvruv-live.hls.adaptive.level3.net/ruv/ruv/index/stream2.m3u8" },
	{ name = "RUV 852x480", url = "http://ruvruv-live.hls.adaptive.level3.net/ruv/ruv/index/stream3.m3u8" },
	{ name = "RUV 1280x720", url = "http://ruvruv-live.hls.adaptive.level3.net/ruv/ruv/index/stream4.m3u8"},
	{ name = "RUV 2 426x240", url = "http://ruvruv2-live.hls.adaptive.level3.net/ruv/ruv2/index/stream1.m3u8"},
	{ name = "RUV 2 640x360", url = "http://ruvruv2-live.hls.adaptive.level3.net/ruv/ruv2/index/stream2.m3u8"},
	{ name = "RUV 2 852x480", url = "http://ruvruv2-live.hls.adaptive.level3.net/ruv/ruv2/index/stream3.m3u8"},
	{ name = "RUV 2 1280x720", url = "http://ruvruv2-live.hls.adaptive.level3.net/ruv/ruv2/index/stream4.m3u8"},
	{ name = "INN", url = "rtmp://79.171.99.70:1935/webtv/innwebtv.stream"},
 	{ name = "N4", url = "http://tv.vodafoneplay.is/n4/index.m3u8"},
	{ name = "Xid977", url = "http://utvarp.visir.is/x-id" },
	{ name = "Ras 1", url = "http://dagskra.ruv.is/ras1/streymi/beint/?48" },
	{ name = "Ras 2", url = "http://dagskra.ruv.is/ras2/streymi/beint/?21" },
	{ name = "Rondo", url = "http://dagskra.ruv.is/rondo/streymi/beint/?79"},
	{ name = "Bylgjan", url = "mmsh://212.30.231.4:80/bylgjan"},
	{ name = "Gull Bylgjan", url = "mmsh://212.30.231.4:80/gull-bylgjan"},
	{ name = "FM 957", url = "mmsh://212.30.231.4:80/fm957"},
	{ name = "KissFM", url = "http://stream.radio.is:443/kiss"},
	{ name = "FlashBack", url = "http://stream.radio.is:443/flashback"},
	{ name = "FmXtra", url = "http://stream.radio.is:443/fmxtra"}
}
 
 
function descriptor()
    return { title = "Icelandic Radio" ;
             version = "1.2" ;
             author = "Hrafnthor" ;
             capabilities = {} }
end

function activate()
    dialog = vlc.dialog("IS_streamer")
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
