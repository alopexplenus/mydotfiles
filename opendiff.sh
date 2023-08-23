#!/bin/sh
 
ide=charm
main_branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')

echo "main branch: >>$main_branch<<"

if [[ -f "./composer.json"  ]]; then
        
        echo "composer.json exists. Assuming its PHP..." 
        ide=storm
fi

function openInIde(){

    if [ -f "$2"  ]; then
            echo "file exists, opening"
            $1 $2
        else
            echo "File does not exist or is not a regular file."
    fi
}

git diff $main_branch... --name-only | while read fname; do openInIde $ide $fname; done

