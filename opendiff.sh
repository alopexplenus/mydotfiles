#!/bin/sh

git diff origin/main --name-only | while read fname; do charm $fname; done

