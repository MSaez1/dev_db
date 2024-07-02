# Use the official Python 3.11 slim image as the base image
FROM python:3.11-slim AS base

# Environment Variables:
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV PYTHONUNBUFFERED=1

# Install the required system packages in a single layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc g++ libpq-dev libcairo2-dev postgresql-client unixodbc unixodbc-dev freetds-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python -m venv "$VIRTUAL_ENV"

# Upgrade pip and install pipenv
RUN pip install --upgrade pip && pip install pipenv

# Set the working directory in the container to /opt/app
WORKDIR /opt/app

# Copy Pipfile and Pipfile.lock to the container and install dependencies
COPY Pipfile* ./
RUN pipenv install --deploy --ignore-pipfile --system --dev

# Copy the entire application code into the container
COPY . .

#Remove restrictions on the permissions of the files in the container
RUN chmod -R 777 /opt/app

# Create a non-root user called 'app', set UID to 1000, and set ownership
RUN useradd -u 1000 -m -d /home/app app && chown -R app:app /opt/app

# Using specific port for development

EXPOSE 5050
# Switch to the 'app' user
USER app

CMD ["python", "app.py"]

