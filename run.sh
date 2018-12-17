#!/bin/bash
if [[ "$1" = train ]]
then
    jupyter nbconvert --to notebook --execute build.ipynb
else
    python -m flask run --host=0.0.0.0
fi