# Use official Python 3.10 image as base
FROM python:3.10-slim

# Set working directory inside the container
WORKDIR /app

# (Optional) Install system dependencies if your package requires them
RUN apt-get update && apt-get install -y \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Copy local package files into the container
# For pip install -e to work, we need setup.py or pyproject.toml in the context
COPY . /app

# Perform editable install
# This allows code changes on your host to reflect immediately inside the container
RUN pip install -e .

RUN /bin/bash -c "mkdir -p data/{input,parsed,generated,curated,final}"

# Default command to keep the container open with a bash shell
CMD ["/bin/bash"]
