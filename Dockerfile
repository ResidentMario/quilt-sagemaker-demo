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
RUN ["python", "-c", "\"import t4; t4.Package.install('aleksey/fashion-mnist-clf', 's3://alpha-quilt-storage', dest='./')\""]
#COPY "aleksey/fashion-mnist-clf/clf.h5" /
#COPY "aleksey/fashion-mnist-clf/build.ipynb" /

# provision environment
ENV FLASK_APP app.py
RUN ["chmod", "+x", "./run.sh"]
EXPOSE 5000
ENTRYPOINT ["./run.sh"]
CMD ["build"]