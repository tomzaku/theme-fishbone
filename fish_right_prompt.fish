

function fish_right_prompt -d "Right side prompt message"

    # A dark grey
    set --local dark_grey e4e4e4

    set_color $dark_grey
    echo -en "\033[1A"
    show_virtualenv_name
    show_git_info
    echo -en (date +%H:%M:%S)

    set_color normal
    echo -en "\033[1B"
end


function show_virtualenv_name -d "Display the name of the current virtualenv"

    if set -q VIRTUAL_ENV
        set_color blue
        echo "["
        set_color yellow
        echo -en (basename "$VIRTUAL_ENV")
        set_color blue
        echo "] "
        set_color normal
    end
end


function show_git_info -d "Show git repository information"

    set --local LIMBO /dev/null
    set --local git_status (git status --porcelain 2> $LIMBO)
    set --local dirty ""

    [ $status -eq 128 ]; and return  # Not a repository? Nothing to do

    # If there is modifications, set repository dirty to '*'
    if not [ -z (echo "$git_status" | grep -e '^ M') ]
        set dirty "*"
    #end

    # If there is new or deleted files, add  '+' to dirty
    else if not [ -z (echo "$git_status" | grep -e '^[MDA]') ]
        set dirty "$dirty+"
    #end

    # If there is stashed modifications on repository, add '^' to dirty
    #if not [ -z (git stash list) ]
    #    set dirty "$dirty^"
    #send
    else
      set dirty "$dirty✓"
    end
    # Prints git repository status
    echo "("
    set_color 8affef
    echo -en (git_branch_name)$dirty
    set_color normal
    echo  ") "
end
