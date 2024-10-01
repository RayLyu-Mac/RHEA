FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git 

WORKDIR /app
COPY ./S1_featureCal /app/S1_featureCal
RUN pip install -r requirements.txt
    
