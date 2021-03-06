-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015 
-- =============================================================
-- 
-- =============================================================
local audio = require "audio"
local sound = {}

-- Local storage for handles to sound files
--
local effects = {}

-- Sound Effects Enable
--
local sfxEn = false
sound.enableSFX = function( enable )
	sfxEn = enable 
end

-- Sound Effect EVENT listener
--
local function onSFX( event )
	local sfx = effects[event.sfx]
	if( not sfx ) then return end
	if( not sfxEn ) then return end
	local channel = audio.findFreeChannel( 2 )
	if( channel ) then
		audio.play( sfx,  { channel = channel } )
	end
end; listen( "onSFX", onSFX )

function sound.init()
	effects["match"] 		= audio.loadSound("sounds/sfx/match.wav")
	effects["win"] 		= audio.loadSound("sounds/sfx/win.wav")
	effects["lose"] 		= audio.loadSound("sounds/sfx/lose.wav")
	effects["click"] 		= audio.loadSound("sounds/sfx/click.mp3")
	effects["explosion"] 	= audio.loadSound("sounds/sfx/explosion.wav")
end

-- Set the sound track file
--
local firstPlay = true
sound.playSoundTrack = function( path )
	if( firstPlay ) then
		firstPlay = false
		local soundTrack = audio.loadStream( path )
		audio.play( soundTrack,  { channel=1, loops=-1, fadein = 3000 } )
	else
		audio.resume( 1 )
	end
end

sound.pauseSoundTrack = function( )
	audio.pause( 1 )
end

return sound