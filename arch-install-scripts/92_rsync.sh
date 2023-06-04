source_user=mpeschel

if test -z "$1"; then
    echo On the host machine, start the server like systemctl start sshd
    echo To grab all directories, provide the hostname or ip of the server.
    echo Otherwise, if you are doing this manually,
    echo  make sure you get:
    echo Anki \~/.local/share/Anki2
    echo ssh \~/.ssh
    echo Startup scripts. I don\'t know which. \~/.vimrc \~/.bash_aliases 
    echo Music Pictures Desktop
    echo  and clean projects before grabbing that, too.
else
    echo Will copy files over from "$1".
    echo While I move the big stuff, clean projects,
    echo  so I don\'t have to copy like 15 node_modules please.

    [ $(pwd) != "/home/mpeschel" ] &&
        echo Are you in /home/mpeschel? Please check. && read

    fast_sources=".ssh .vimrc .bash_aliases .local/share/Anki2"
    slow_sources="Music Pictures Desktop"
    targets="$fast_sources $slow_sources"
    echo
    echo First round of directories:
    echo $targets

    echo Press enter when ready.
    read

    s=""
    root="$source_user@$1:"
    for target in $targets; do
        next="$root$target"
        if test -z "$s"; then
            s="$next"
        else
            s="$s $next"
        fi  
    done

    rsync -av $s ./

    echo Ok, everything but projects is copied over.
    echo Press enter when ready to copy projects.
    read
    rsync -av "${source_user}@${1}:projects" ./
fi

echo
echo Afterwards, make sure to:
echo install zoom, anki
echo and do the other things in migration. Set up keyboard shortcuts etc.

