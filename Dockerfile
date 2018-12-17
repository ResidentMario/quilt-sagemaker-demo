FROM python:3.6

# set the working directory
RUN ["mkdir", "app"]
WORKDIR "app"

# install environment dependencies
COPY "requirements.txt" .
COPY "app.py" .
COPY "run.sh" .

# install code dependencies
RUN ["pip", "install", "-r", "requirements.txt"]

# install model dependencies
# T4 performs write operations on an AWS S3 bucket, which in turn requires valid AWS credentials.
# It would be more secure to provide these values at run time, as they are accessible to anyone with access to the image
# via `docker history`. We put them here, in the build step, for concordance with the other dependencies. For an
# experimental endpoint this is acceptable.
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_REGION=us-east-1
RUN if [ "$AWS_ACCESS_KEY_ID" ]; then aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID; fi
RUN if [ "$AWS_SECRET_ACCESS_KEY" ]; then aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY; fi
RUN python -c "import t4; t4.Package.install('aleksey/fashion-mnist-clf', 's3://alpha-quilt-storage', dest='./')"

# provision environment
ENV FLASK_APP app.py
RUN ["chmod", "+x", "./run.sh"]
EXPOSE 5000
ENTRYPOINT ["./run.sh"]
CMD ["build"]