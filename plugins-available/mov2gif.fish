
function mov2gif --description "Convert mov to a gif in dropbox"
	ffmpeg -i $argv -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > ~/Dropbox/Public/Screenshots/Screencast-(date +"%Y.%m.%d-%H.%M").gif;
end