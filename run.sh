#!/bin/bash
if [[ "$1" = build ]]
then
    python -m flask run --host=0.0.0.0
else
    echo "$1"
fi