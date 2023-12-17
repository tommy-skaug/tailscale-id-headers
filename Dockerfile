FROM alpine:3.17

WORKDIR /app

RUN apk add --no-cache python3 py3-gunicorn py3-flask

ADD . /app
EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "listener:app"]