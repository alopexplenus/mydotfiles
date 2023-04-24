#!/usr/bin/zsh

weekly_note=$(date +"%Y-KW%V.md")
weekly_note_heading=$(date +"# KW%V\n")
previous_weekly_note=$(date +"%Y-KW%V.md" -d "7 days ago")

git -C ~/notes  pull 

if [[ ! -f ~/notes/$weekly_note ]]; then
    echo "$weekly_note_heading" > ~/notes/$weekly_note
    echo $(date +"# %d.%m\n") >> ~/notes/$weekly_note

    echo "\n\n# What have I done?!\n" >> ~/notes/$previous_weekly_note

    cat ~/notes/todos.md | grep "\[[xX]\]" >> ~/notes/$previous_weekly_note
    sed -i '/^\- \[[xX]\].*/d' ~/notes/todos.md

    cat ~/notes/f/todos.md | grep "\[[xX]\]" >> ~/notes/$previous_weekly_note
    sed -i '/^\- \[[xX]\].*/d' ~/notes/f/todos.md

fi

