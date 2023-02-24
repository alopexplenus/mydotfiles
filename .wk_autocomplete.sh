_wake_autocomplete()
{
    local cur
    COMPREPLY=( $( compgen -W "$(ls ~/projects/)" -- "$cur"  )  )
    return 0
}

## dunno which is correct in my case
complete -o nospace -F _wake_autocomplete wk.sh
