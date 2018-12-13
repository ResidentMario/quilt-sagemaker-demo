FROM python:3
COPY "app.py" /
COPY "requirements.txt" /
COPY "run.sh" /
RUN ["pip", "install", "-r", "requirements.txt"]
RUN ["chmod", "+x", "/run.sh"]
ENV FLASK_APP app.py
EXPOSE 5000
ENTRYPOINT ["/run.sh"]
CMD ["build"]