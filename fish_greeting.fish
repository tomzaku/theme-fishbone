

function fish_greeting -d "Greeting message on shell session start up"

    echo ""
    echo -en "        |         " (welcome_message) "\n"
    echo -en "       / \        \n"
    echo -en "      / _ \       " (show_date_info) "\n"
    echo -en "     |.o '.|      \n"
    echo -en "     |'._.'|      Space vessel computer:\n"
    echo -en "     |     |      " (show_os_info) "\n"
    echo -en "   ,'|  |  |`.    " (show_cpu_info) "\n"
    echo -en "  /  |  |  |  \   " (show_mem_info) "\n"
    echo -en "  |,-'--|--'-.|   " (show_net_info) "\n"
    echo ""
    set_color grey
    fortune
    set_color normal
end


function welcome_message -d "Say welcome to user"

    echo -en "Welcome aboard captain "
    set_color FFF  # white
    echo -en (whoami) "!"
    set_color normal
end


function show_date_info -d "Prints information about date"

    set --local up_time (uptime |sed 's/^ *//g' |cut -d " " -f4,5 |tr -d ",")

    echo -en "Today is "
    set_color cyan
    echo -en (date +%Y.%m.%d,)
    set_color normal
    echo -en " we are up and running for "
    set_color cyan
    echo -en "$up_time"
    set_color normal
    echo -en "."
end


function show_os_info -d "Prints operating system info"

    set_color yellow
    echo -en "\tOS: "
    set_color 0F0  # green
    #echo -en (uname -sm)
    echo "MacBook Air (13-inch, Mid 2013)"
    set_color normal
end


function show_cpu_info -d "Prints iformation about cpu"

    set --local os_type (uname -s)
    set_color yellow
    echo -en "\tCPU: "
    set_color 0F0  # green
    #echo -en $cpu_info
    echo -en "1 processors, 4 cores, IntelCorei7"
    set_color normal
end


function show_mem_info -d "Prints memory information"

    set --local os_type (uname -s)


    set_color yellow
    echo -en "\tMemory: "
    set_color 0F0  # green
    #echo -en $total_memory
    echo -en "8GB"
    set_color normal
end


function show_net_info -d "Prints information about network"

    set --local os_type (uname -s)
    set --local ip ""
    set --local gw ""

    if [ "$os_type" = "Linux" ]
        set ip (ip addr show | grep -v "127.0.0.1" | grep "inet "| sed 's/^ *//g' | cut -d " " -f2)
        set gw (netstat -nr | grep UG | cut -d " " -f10)
    else if [ "$os_type" = "Darwin" ]
        set ip (ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | cut -d " " -f2)
        set gw (netstat -nr | grep default | cut -d " " -f13)
    end

    set_color yellow
    echo -en "\tNet: "
    set_color 0F0  # green
    echo -en "Ip address $ip, default gateway $gw"
    set_color normal
end
