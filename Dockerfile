FROM python:3-alpine

# Create app directory inside the container
WORKDIR /app

# Update package repository, upgrade installed packages, and install these dependencies through apk before pip
RUN apk update && apk upgrade && apk add --no-cache ffmpeg && apk add sqlite && apk add flac

# Copy the requirements.txt file to the container
COPY requirements.txt ./

# Install the Python app dependencies listed in requirements.txt
RUN pip install -r requirements.txt

# Bundle app source
COPY . .

# Container listens on port 8000 when/if it runs
EXPOSE 8000

# When the container starts, use the Gunicorn HTTP server to serve the application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "wsgi:app"]
