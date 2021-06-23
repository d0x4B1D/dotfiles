typeset -AHg ICONS

ICONS=(
    seperator_left     $'\ue0b0'
    seperator_right    $'\ue0b2'
    check              $'\uf00c'
    no_check           $'\uf00d'
)

function colorize_right() {
    if [ -z "$4" ]; then
        echo "%{$FG[$2]%}$ICONS[seperator_right]%{${reset_color}%}%{$FG[$1]%}%{$BG[$2]%} $3 %{${reset_color}%}"
    else
        echo "%{$FG[$2]%}%{$BG[$4]%}$ICONS[seperator_right]%{${reset_color}%}%{$FG[$1]%}%{$BG[$2]%} $3 %{${reset_color}%}"
    fi
}

function colorize_left() {
    if [ -z "$4" ]; then
        echo "%{$FG[$1]%}%{$BG[$2]%} $3 %{${reset_color}%}%{$FG[$2]%}$ICONS[seperator_left]%{${reset_color}%}"
    else
        echo "%{$FG[$1]%}%{$BG[$2]%} $3 %{${reset_color}%}%{$FG[$2]%}%{$BG[$4]%}$ICONS[seperator_left]%{${reset_color}%}"
    fi
}

function build_preprompt_left() {
    local user_text="$(colorize_left 000 015 $USER 004)"
    local directory_text="$(colorize_left 000 004 %~)"
    echo "${user_text}${directory_text}"
}

function build_preprompt_right() {
    local time_text="$(colorize_right 000 015 %T 240)"
    local return_text=""
    if [ $1 -eq 0 ]; then 
        return_text="$(colorize_right 002 240 $ICONS[check])"
    else
	return_text="$(colorize_right 001 240 "$ICONS[no_check] $1")"
    fi
    echo "${return_text}${time_text}"
}

function build_prompt() {
    echo "$ "
}
