FROM python:3.13

RUN apt update && apt install -y git

WORKDIR /app

COPY setup.sh setup.sh
COPY getImage.sh getImage.sh
COPY patches patches
RUN ["chmod", "+x", "-R", "./"]

RUN ["bash", "-c", "./setup.sh"]

# 取得元を変える場合は DYNMAP_BASE_URL を指定する
ENV DYNMAP_BASE_URL=https://api.torosaba.net/map/v1

CMD ["bash", "-c", "./getImage.sh"]