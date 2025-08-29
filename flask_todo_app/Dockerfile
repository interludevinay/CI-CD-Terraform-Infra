# Base image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy packages to the container
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy the rest application code
COPY . .

# Expose the port
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

CMD ["flask","run"]
