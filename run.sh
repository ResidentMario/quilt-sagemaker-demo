#!/bin/bash
if [ ! "$AWS_ACCESS_KEY_ID" = "" ]; then aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID; fi
if [ ! "$AWS_SECRET_ACCESS_KEY" = "" ]; then aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY; fi

if [[ "$1" = train ]]
then
    jupyter nbconvert --to notebook --execute build.ipynb
else
    python -m flask run --host=0.0.0.0
fi