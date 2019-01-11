#!/bin/bash
if [ ! "$AWS_ACCESS_KEY_ID" = "" ]; then aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID; fi
if [ ! "$AWS_SECRET_ACCESS_KEY" = "" ]; then aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY; fi

if [[ "$1" = train ]]
then
    cat ~/.aws/config
    python -c "from sagemaker import get_execution_role; get_execution_role()"
    jupyter nbconvert --execute --ExecutePreprocessor.timeout=-1 --to notebook build.ipynb
else
    python -c "import t4; t4.Package.install('aleksey/fashion-mnist-clf', registry='s3://alpha-quilt-storage', dest='.')"
    cp aleksey/fashion-mnist-clf/clf.h5 clf.h5
    rm -rf aleksey/
    python -m flask run --host=0.0.0.0
fi
