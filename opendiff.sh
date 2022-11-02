#!/bin/sh

git diff main... --name-only | while read fname; do charm $fname; done

