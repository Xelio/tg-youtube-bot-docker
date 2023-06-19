FROM python:3.10-alpine as base

FROM base as builder

RUN mkdir /install
WORKDIR /install

COPY requirements.txt /requirements.txt
RUN pip install --user -r /requirements.txt

FROM base

COPY --from=builder /root/.local /root/.local

RUN apk update && apk add --no-cache ffmpeg

WORKDIR /
COPY . .

CMD ["python3","-u","bot.py"]
