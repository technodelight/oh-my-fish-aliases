#!/usr/local/bin/fish

if [ ! -L ~/.oh-my-fish/custom/zenc-aliases.load ]
    ln -s $PWD/zenc-aliases.load ~/.oh-my-fish/custom/zenc-aliases.load
    echo "Load file link created"
else
    echo "Load file link alreay exists"
end

if [ ! -L ~/.oh-my-fish/custom/plugins/zenc-aliases ]
    ln -s $PWD/plugins/zenc-aliases ~/.oh-my-fish/custom/plugins/zenc-aliases
    echo "Directory link created"
else
    echo "Directory already linked"
end

if [ -L ~/.oh-my-fish/custom/zenc-aliases.load ]
    source ~/.oh-my-fish/custom/zenc-aliases.load
else
    echo "Configuration file ~/.oh-my-fish/custom/zenc-aliases.load is possibly a broken symlink. Remove and run install again"
end

