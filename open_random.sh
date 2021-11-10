#!/bin/bash

shuf -en1 "$@" | xargs -d "\n" xdg-open