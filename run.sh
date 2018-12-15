#!/bin/bash
if [[ "$1" = train ]]
then
    echo "$1"
else
    python -m flask run --host=0.0.0.0
fi