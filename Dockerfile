# Use lightweight Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirements first (for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy project files
COPY flask_todo_app/ ./flask_todo_app/


# Expose port
EXPOSE 5000

# Start app
CMD ["flask", "run"]
