#!/bin/sh
 

if [ -z "$1"  ]; then
    base_branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
    echo "main branch: >>$base_branch<<"
else
    base_branch=$1
fi


ide=charm

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

git diff $base_branch... --name-only | while read fname; do openInIde $ide $fname; done

