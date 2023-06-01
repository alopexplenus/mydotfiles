_wake_autocomplete()
{
    local cur
    COMPREPLY=( $( compgen -W "$(ls ~/projects/)" -- "$cur"  )  )
    return 0
}

complete -o nospace -F _wake_autocomplete wk.sh
