# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt requirements.txt

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install the node exporter
RUN pip install Flask prometheus_flask_exporter


# Copy the application code
COPY app.py app.py

# Expose the application port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
