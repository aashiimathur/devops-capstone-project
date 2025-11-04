# Use Python 3.9 slim as the base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the service folder into the image
COPY service/ service/

# Create a non-root user called theia
RUN useradd -m theia

# Change ownership of the /app folder to theia
RUN chown -R theia:theia /app

# Switch to theia user
USER theia

# Expose port 8080
EXPOSE 8080

# Run the service using gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
