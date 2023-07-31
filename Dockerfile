# Start from a base image
FROM python:3.9

# Set a directory for the app
WORKDIR /usr/src/app

# Copy all files to the app directory
COPY . .

# Install dependencies for pycairo
RUN apt-get update && apt-get install -y pkg-config python3-dev libcairo2-dev

# Install python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# To run the container: docker run -it geoldm_image /bin/bash

