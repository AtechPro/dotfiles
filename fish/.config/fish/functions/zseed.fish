function zseed --description 'Seed zoxide with project directories under $HOME'
    # Curated project roots — add new ones here.
    set -l dirs \
        $HOME/cleanyourtv \
        $HOME/dotfiles \
        $HOME/mtkclient \
        $HOME/pear-desktop \
        $HOME/stable-diffusion-webui-forge \
        $HOME/tv-debloat \
        $HOME/tv-launchers \
        $HOME/tv-launchers/hume \
        $HOME/tv-launchers/tvos-src \
        $HOME/tv-launchers/weatherglass \
        $HOME/quick_project \
        $HOME/loginface \
        $HOME/floci \
        $HOME/yay

    # Auto-pick any git repo sitting directly under $HOME (skips dotdirs).
    for d in $HOME/*/
        if test -d $d.git
            set -a dirs (string trim -r -c / -- $d)
        end
    end

    set -l seen
    set -l added 0
    for d in $dirs
        if test -d $d; and not contains -- $d $seen
            set -a seen $d
            zoxide add -- $d >/dev/null
            set added (math $added + 1)
        end
    end

    set -l total (zoxide query -l | count)
    echo "zseed: $added project dirs added, $total tracked in zoxide"
end
