#!/bin/sh
 
ide=charm
main_branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')

echo "main branch: >>$main_branch<<"

if [[ -f "./composer.json"  ]]; then
        
        echo "composer.json exists. Assuming its PHP..." 
        ide=storm
fi
git diff $main_branch... --name-only | while read fname; do $ide $fname; done

