_run_autocomplete()
{
    local cur
    COMPREPLY=( $( compgen -W "$(ls ./scripts/)" -- "$cur"  )  )
    return 0
}

complete -o nospace -F _run_autocomplete run
