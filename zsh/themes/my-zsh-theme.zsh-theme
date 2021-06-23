precmd() {
    local return_value=$?
    local preprompt_left="$(build_preprompt_left)"
    local preprompt_right="$(build_preprompt_right $return_value)"
    local preprompt_left_length=${#${(S%%)preprompt_left//(\%([KF1]|)\{*\}|\%[Bbkf])}}
    local preprompt_right_length=${#${(S%%)preprompt_right//(\%([KF1]|)\{*\}|\%[Bbkf])}}
    local num_filler_spaces=$((COLUMNS - preprompt_left_length - preprompt_right_length))
    print -Pr "$preprompt_left${(l:$num_filler_spaces:)}$preprompt_right"
}
PROMPT='$(build_prompt)'
