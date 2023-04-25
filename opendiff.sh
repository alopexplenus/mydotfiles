#!/bin/sh
 
ide=charm
main_branch=main
git rev-parse --verify master && main_branch=master
if [[ -f "./composer.json"  ]]; then
        
        echo "composer.json exists. Assuming its PHP..." 
        ide=storm
fi
git diff $main_branch... --name-only | while read fname; do $ide $fname; done

