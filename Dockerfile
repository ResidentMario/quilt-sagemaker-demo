FROM python:3.6

# set the working directory
RUN ["mkdir", "app"]
WORKDIR "app"

# install code dependencies
COPY "requirements.txt" .
RUN ["pip", "install", "-r", "requirements.txt"]

# install environment dependencies
COPY "app.py" .
COPY "run.sh" .
COPY "build.ipynb" .
COPY "catalog-screencap.png" .

# XXX: temp patch until install works again
# this only works locally b/c fashion-mnist_train.csv is too large to distribute via git
# until the large file push bug is fixed we're stuck here, once it's patched remove and continue
COPY "fashion-mnist_train.csv" .
COPY "health-check-data.csv" .

# install model dependencies
# following Docker data model and AWS security best practices means pulling the necessary data at runtime
ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV AWS_REGION=us-east-1

# provision environment
ENV FLASK_APP app.py
RUN ["chmod", "+x", "./run.sh"]
EXPOSE 5000
ENTRYPOINT ["./run.sh"]
CMD ["build"]